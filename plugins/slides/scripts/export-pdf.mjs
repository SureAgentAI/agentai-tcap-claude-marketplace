#!/usr/bin/env node

/**
 * Export an HTML slide presentation to a pixel-perfect PDF.
 *
 * How it works:
 *   1. Opens the HTML file in headless Puppeteer at a fixed viewport
 *   2. For each <section class="slide">, hides all other slides and
 *      positions the current slide as position:fixed filling the viewport
 *   3. Screenshots the viewport (not the element — avoids scroll-snap issues)
 *   4. Assembles screenshots into a PDF via pdf-lib
 *
 * This approach avoids print CSS entirely — no viewport collapse, no
 * resolution change, no 100vh breakage. What you see in the browser
 * is exactly what ends up in the PDF.
 *
 * Usage:
 *   node export-pdf.mjs <input.html> [output.pdf] [options]
 *
 * Options:
 *   --width=N          Viewport width in px (default: 1920)
 *   --height=N         Viewport height in px (default: 1080)
 *   --scale=N          Device scale factor, 1=standard, 2=retina (default: 2)
 *   --quality=N        JPEG quality 1-100 (default: 95)
 *   --selector=S       CSS selector for slides (default: section.slide)
 *   --pause=N          Ms to wait per slide for rendering (default: 500)
 *
 * Dependencies (install in same dir or globally):
 *   npm install puppeteer pdf-lib
 */

import { createRequire } from 'module';
import { writeFile } from 'fs/promises';
import { resolve } from 'path';

// Resolve deps from /tmp/node_modules (where the command installs them)
const require = createRequire('/tmp/node_modules/.package-lock.json');
const puppeteer = (await import(require.resolve('puppeteer'))).default;
const { PDFDocument } = await import(require.resolve('pdf-lib'));

// --- Parse CLI args ---
const args = process.argv.slice(2);
const flags = {};
const positional = [];

for (const arg of args) {
  if (arg.startsWith('--')) {
    const [key, val] = arg.slice(2).split('=');
    flags[key] = val ?? 'true';
  } else {
    positional.push(arg);
  }
}

const input = positional[0];
if (!input) {
  console.error('Usage: node export-pdf.mjs <input.html> [output.pdf] [--width=1920] [--height=1080] [--scale=2] [--quality=95]');
  process.exit(1);
}

const inputPath = resolve(input);
const outputPath = positional[1]
  ? resolve(positional[1])
  : inputPath.replace(/\.html?$/i, '.pdf');

const WIDTH    = parseInt(flags.width)   || 1920;
const HEIGHT   = parseInt(flags.height)  || 1080;
const SCALE    = parseInt(flags.scale)   || 2;
const QUALITY  = parseInt(flags.quality) || 95;
const SELECTOR = flags.selector          || 'section.slide';
const PAUSE    = parseInt(flags.pause)   || 500;

// --- Export ---
const browser = await puppeteer.launch({ headless: 'new' });
const page = await browser.newPage();
await page.setViewport({ width: WIDTH, height: HEIGHT, deviceScaleFactor: SCALE });
await page.goto(`file://${inputPath}`, { waitUntil: 'networkidle0', timeout: 30000 });

const slideCount = await page.evaluate(
  (sel) => document.querySelectorAll(sel).length,
  SELECTOR
);

if (slideCount === 0) {
  console.error(`No slides found with selector "${SELECTOR}"`);
  await browser.close();
  process.exit(1);
}

console.log(`Exporting ${slideCount} slides at ${WIDTH}x${HEIGHT} @${SCALE}x, JPEG q${QUALITY}`);

const pdf = await PDFDocument.create();

for (let i = 0; i < slideCount; i++) {
  // Hide all slides except current; position current as fixed fullscreen
  await page.evaluate((idx, sel) => {
    const slides = document.querySelectorAll(sel);
    slides.forEach((s, j) => {
      if (j === idx) {
        s.style.display = '';
        s.style.position = 'fixed';
        s.style.top = '0';
        s.style.left = '0';
        s.style.width = '100vw';
        s.style.height = '100vh';
        s.style.zIndex = '9999';
      } else {
        s.style.display = 'none';
      }
    });
  }, i, SELECTOR);

  await new Promise(r => setTimeout(r, PAUSE));

  const screenshot = await page.screenshot({ type: 'jpeg', quality: QUALITY });
  const image = await pdf.embedJpg(screenshot);
  const pdfPage = pdf.addPage([WIDTH, HEIGHT]);
  pdfPage.drawImage(image, { x: 0, y: 0, width: WIDTH, height: HEIGHT });

  process.stdout.write(`  ${i + 1}/${slideCount}\r`);
}

const pdfBytes = await pdf.save();
await writeFile(outputPath, pdfBytes);
const sizeMB = (pdfBytes.length / 1024 / 1024).toFixed(1);
console.log(`\nPDF saved: ${outputPath} (${sizeMB} MB, ${slideCount} pages)`);

await browser.close();

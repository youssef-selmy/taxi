# Icon Font Generation Guide

This guide explains how to generate font icons from SVG files using our two-step process.

## Prerequisites

- Dart SDK
- Node.js and npm/npx
- SVG icon files that you want to convert

## Step 1: Extract SVGs to a Single Directory

First, run the `icons.dart` script to extract all SVG files into a single directory:

```bash
dart icons.dart
```

This script will collect all SVG files from their source locations and place them in the `./svgs` directory for processing.

## Step 2: Generate Font Icons

After extracting the SVGs, use the `svgtofont` tool to generate font icons:

```bash
sudo npx svgtofont --sources ./svgs --output ./font --fontName better-font
```

This command will:

- Use SVG files from the `./svgs` directory
- Output the generated font files to the `./font` directory
- Name the font "better-font"

## Output Files

After completing these steps, you'll find the following files in the `./font` directory:

- `better-font.ttf` - TrueType font file
- `better-font.woff` - Web Open Font Format file
- `better-font.woff2` - Web Open Font Format 2.0 file
- `better-font.eot` - Embedded OpenType font file
- `better-font.svg` - SVG font file
- CSS and other supporting files

## Use icomoon.io to generate the font files

1. Go to icomoon.io
2. Click on the "Import Icons" button
3. Select the `selection.json` file in the `./icomoon` directory
4. Click on the "Generate Font" button
5. Download the generated font files
6. Extract the downloaded zip file
7. Copy the extracted files to the `./font` directory
8. Run below command to generate the font files

```sh
dart run icomoon_generator:generator
```

## Integration

To use these font icons in your project, refer to the CSS files in the `./font` directory for implementation details.

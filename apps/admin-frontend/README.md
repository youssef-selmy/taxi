# admin_frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Generate icon file

First we have to convert svg strokes to fills using osllo/svg-fixer:
`npm i oslllo-svg-fixer -g`

then:
`oslllo-svg-fixer -s ./ -d ./ --tr 1200`

then we import the svgs into icomoon.io and export as TTF. Copy ttf and selection.json into font folder and then run below command:

`dart run icomoon_generator:generator`


v3.x:
flutter pub run icon_font_generator gen --from assets/icons/ --out-font=assets/fonts/my_icons_font.ttf --out-flutter=lib/my_icons.dart --class-name MyIcons

v4.x:
icon_font_generator:generator



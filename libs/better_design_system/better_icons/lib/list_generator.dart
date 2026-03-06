import 'dart:io';

void generateDictionary() {
  final file = File('./better_icon.dart');
  final lines = file.readAsLinesSync();
  final regex = RegExp(r'static const IconData (\w+) = IconData');

  final buffer = StringBuffer();
  buffer.writeln('import \'package:flutter/material.dart\';');

  buffer.writeln('import \'better_icon.dart\';');
  buffer.writeln();

  buffer.writeln('const Map<String, IconData> betterIconsDictionary = {');

  for (var line in lines) {
    final match = regex.firstMatch(line);
    if (match != null) {
      final iconName = match.group(1);
      buffer.writeln("  '$iconName': BetterIcons.$iconName,");
    }
  }

  buffer.writeln('};');

  final outputFile = File('./list.dart');
  outputFile.writeAsStringSync(buffer.toString());
}

void main() {
  generateDictionary();
}

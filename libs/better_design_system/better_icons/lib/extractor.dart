// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  final directory = Directory(path.dirname(Platform.script.toFilePath()));
  final iconsDirPath = path.join(directory.path, 'Icons');
  print('Icons directory path: $iconsDirPath');
  final iconsDir = Directory(iconsDirPath);

  if (iconsDir.existsSync()) {
    final typeFolders = iconsDir.listSync().whereType<Directory>();

    print('Folders within icons directory:');
    for (final typeFolder in typeFolders) {
      final categoryFolders = typeFolder.listSync().whereType<Directory>();

      for (final categoryFolder in categoryFolders) {
        final iconFiles = categoryFolder.listSync().whereType<File>();

        print('Category: ${categoryFolder.path}');
        for (final iconFile in iconFiles) {
          // copy the file to the svg folder with format 'type_category_name.svg'
          final iconFileName = path.basenameWithoutExtension(iconFile.path);
          final iconType = path.basename(typeFolder.path);
          final iconNewPath = path.join(
            directory.path,
            'svgs',
            '${iconFileName}_$iconType.svg'.toLowerCase(),
          );
          final newFile = File(iconNewPath);
          // Ensure the directory exists
          newFile.parent.createSync(recursive: true);
          // Copy the file
          iconFile.copySync(iconNewPath);
          print('Copied: ${iconFile.path} -> $iconNewPath');
          // run svg2font command on svg folder
          // final process = Process.runSync('svgtofont', [
          //   '--sources',
          //   './',
          //   '--output',
          //   './fonts',
          //   '--fontName',
          //   'better-font',
          // ], workingDirectory: newFile.parent.path);
        }
      }
    }
  } else {
    print('Icons directory not found at: $iconsDirPath');
  }
}

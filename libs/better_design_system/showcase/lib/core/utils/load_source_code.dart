import 'package:flutter/services.dart' show rootBundle;

Future<String> loadSourceCode(String fileName) async {
  return await rootBundle.loadString('assets/sources/$fileName');
}

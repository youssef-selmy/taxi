import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static void i(dynamic message) => _logger.i(message);
  static void d(dynamic message) => _logger.d(message);
  static void e(dynamic message) => _logger.e(message);
}

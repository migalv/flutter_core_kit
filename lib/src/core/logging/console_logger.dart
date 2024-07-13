import 'package:flutter_core_kit/src/core/logging/i_logger.dart';
import 'package:logger/logger.dart';

/// Logger that prints all the [Level.debug] messages to the system console using the [Logger] package & [PrettyPrinter]
class ConsoleLogger implements ILogger {
  /// Logger that prints all the [Level.debug] messages to the system console using the [Logger] package & [PrettyPrinter]
  ConsoleLogger();

  final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  @override
  void debug(String message, {Map<String, String?>? properties}) => _logger.d(message);

  @override
  void info(String message, {Map<String, String?>? properties}) => _logger.i(message);

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, String?>? properties,
  }) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void error(
    String message, {
    required Object error,
    required StackTrace stackTrace,
    Map<String, String?>? properties,
  }) =>
      _logger.d(message, error: error, stackTrace: stackTrace);
}
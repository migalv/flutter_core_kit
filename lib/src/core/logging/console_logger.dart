import 'package:flutter_core_kit/src/core/logging/i_logger.dart';
import 'package:logger/logger.dart';
import 'package:talker/talker.dart';

/// Logger that prints all the [Level.debug] messages to the system console using the [Logger] package & [PrettyPrinter]
class ConsoleLogger implements ILogger {
  /// Logger that prints all the [Level.debug] messages to the system console using the [Logger] package & [PrettyPrinter]
  ConsoleLogger({
    LogLevel logLevel = LogLevel.debug,
  }) : _logger = Talker(
          logger: TalkerLogger(
            settings: TalkerLoggerSettings(level: logLevel),
          ),
        );

  final Talker _logger;

  @override
  void debug(String message, {Map<String, String?>? properties}) => _logger.debug(message);

  @override
  void info(String message, {Map<String, String?>? properties}) => _logger.info(message);

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, String?>? properties,
  }) =>
      _logger.warning(message, error, stackTrace);

  @override
  void error(
    String message, {
    required Object error,
    required StackTrace stackTrace,
    Map<String, String?>? properties,
  }) =>
      _logger.error(message, error, stackTrace);
}

import 'package:flutter_core_kit/src/core/logging/i_log_level.dart';
import 'package:flutter_core_kit/src/core/logging/i_logger.dart';
import 'package:talker/talker.dart';

/// {@template ConsoleLogger}
/// Logger that prints all the messages to the system console using the [TalkerLogger] package
///
/// By default prints [ILogLevel.debug]
/// {@endtemplate}
class ConsoleLogger implements ILogger {
  /// {@macro ConsoleLogger}
  ConsoleLogger({
    ILogLevel logLevel = ILogLevel.debug,
  }) : _logger = Talker(
          logger: TalkerLogger(
            settings: TalkerLoggerSettings(level: logLevel.toTalker()),
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

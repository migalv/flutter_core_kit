import 'dart:convert';

import 'package:flutter_core_kit/src/core/logging/i_logger.dart';

/// A basic implementation of the [ILogger] interface. It logs to the console.
///
/// Optionally it can log to any output, by adding the logger to the `registeredLoggers` list
class AppLogger implements ILogger {
  /// Creates a logger instance. It is recommended to create an instance for each file to have a different [baseContext]
  ///
  /// - [consoleLogger] Logger used to print to the console
  /// - [baseContext] will be added to every log in between "[]". This is usually the name of the class where this
  /// logger will be used
  /// - [registeredLoggers] (Optional) a list of loggers that will also be called for their respective log levels
  const AppLogger({
    /// Logger used to print to the console
    required ILogger consoleLogger,

    /// Will be added to every log in between "[]". This is usually the name of the class where this
    required String baseContext,

    /// (Optional) A list of loggers that will also be called for their respective log levels
    ///
    /// For example:
    /// - Logger that will store the logs in a local file
    /// - Logger that send the logs to a crash report system
    List<ILogger> registeredLoggers = const [],
  })  : _consoleLogger = consoleLogger,
        _baseContext = baseContext,
        _registeredLoggers = registeredLoggers;

  final ILogger _consoleLogger;
  final List<ILogger> _registeredLoggers;

  /// The base context is the context that was used to create this logger -
  final String _baseContext;

  /// This log will only be logged to the console & optionally to a local file with DEBUG level
  @override
  void debug(
    /// Required message that will be appended to the log information
    String message, {
    /// Optional map with properties that can be a key-value pair of relevant information for the log
    /// that will be encoded in JSON format and appended at the end of the message
    Map<String, String?>? properties,
  }) {
    _consoleLogger.debug(
      _formatLog(message, properties),
      properties: properties,
    );

    for (final logger in _registeredLoggers) {
      logger.debug(
        _formatLog(message, properties),
        properties: properties,
      );
    }
  }

  /// This log will be logged to the systems the console, crash report system & optionally to a local file with INFO level
  @override
  void info(
    /// Required message that will be appended to the log information
    String message, {
    /// Optional map with properties that can be a key-value pair of relevant information for the log
    /// that will be encoded in JSON format and appended at the end of the message
    Map<String, String?>? properties,
  }) {
    _consoleLogger.info(
      _formatLog(message, properties),
      properties: properties,
    );

    for (final logger in _registeredLoggers) {
      logger.info(
        _formatLog(message, properties),
        properties: properties,
      );
    }
  }

  /// This log will be logged to the systems the console, crash report system & optionally to a local file with WARNING level
  ///
  /// This error is very often handled & the app can recover from this state
  @override
  void warning(
    /// Required message that will be appended to the log information
    String message, {
    /// The error that happened. Ideally it should be descriptive enough & point to a specific part of the code
    Object? error,

    /// The stack trace that originated this error. If logging is being done outside a try-catch use **StackTrace.current**
    StackTrace? stackTrace,

    /// Optional map with properties that can be a key-value pair of relevant information for the log
    /// that will be encoded in JSON format and appended at the end of the message
    Map<String, String?>? properties,
  }) {
    _consoleLogger.warning(
      _formatLog(message, properties),
      error: error,
      stackTrace: stackTrace,
      properties: properties,
    );

    for (final logger in _registeredLoggers) {
      logger.warning(
        _formatLog(message, properties),
        properties: properties,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Error logs are used to inform that an error ocurred that should be notified to the development team
  ///
  /// This log will be logged to the systems the console, crash report system & optionally to a local file with ERROR level
  ///
  /// This error was not handled & the app cannot recover from this state
  @override
  void error(
    /// Required message that will be appended to the log information
    String message, {
    /// The error that happened. Ideally it should be descriptive enough & point to a specific part of the code
    required Object error,

    /// The stack trace that originated this error. If logging is being done outside a try-catch use **StackTrace.current**
    required StackTrace stackTrace,

    /// Optional map with properties that can be a key-value pair of relevant information for the log
    /// that will be encoded in JSON format and appended at the end of the message
    Map<String, String?>? properties,
  }) {
    _consoleLogger.error(
      _formatLog(message, properties),
      error: error,
      stackTrace: stackTrace,
      properties: properties,
    );

    for (final logger in _registeredLoggers) {
      logger.error(
        _formatLog(message, properties),
        properties: properties,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _formatLog(
    String message,
    Map<String, dynamic>? properties, {
    bool addTimestamp = false,
  }) {
    var logMessage = '';

    if (addTimestamp) {
      final now = DateTime.now();
      logMessage += '$now';
    }

    logMessage += '[$_baseContext]: $message';

    if (properties != null) {
      final jsonProperties = jsonEncode(properties);

      logMessage += '\n - [Properties] = $jsonProperties';
    }

    return logMessage;
  }
}

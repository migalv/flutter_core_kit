import 'dart:convert';

import 'package:flutter_core_kit/src/core/logging/i_logger.dart';

/// The global app logger class to log any necessary messages or errors
class AppLogger implements ILogger {
  /// Creates a logger instance. It is recommended to create an instance for each file to have a different [baseContext]
  ///
  /// - [consoleLogger] Logger used to print to the console
  /// - [baseContext] will be added to every log in between "[]". This is usually the name of the class where this
  /// logger will be used
  const AppLogger({
    /// Logger used to print to the console
    required ILogger consoleLogger,

    /// Will be added to every log in between "[]". This is usually the name of the class where this
    required String baseContext,

    /// (Optional) Logger that will store the logs in a local file
    ILogger? fileLogger,

    /// (Optional) Logger that send the logs to a crash report system
    ILogger? crashReportLogger,
  })  : _crashReportLogger = crashReportLogger,
        _fileLogger = fileLogger,
        _consoleLogger = consoleLogger,
        _baseContext = baseContext;

  final ILogger _consoleLogger;
  final ILogger? _fileLogger;
  final ILogger? _crashReportLogger;

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

    _fileLogger?.debug(
      _formatLog(message, properties),
      properties: properties,
    );

    _crashReportLogger?.debug(
      _formatLog(message, properties),
      properties: properties,
    );
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

    _fileLogger?.info(
      _formatLog(message, properties),
      properties: properties,
    );

    _crashReportLogger?.info(
      _formatLog(message, properties),
      properties: properties,
    );
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

    _fileLogger?.warning(
      _formatLog(message, properties),
      error: error,
      stackTrace: stackTrace,
      properties: properties,
    );

    _crashReportLogger?.warning(
      _formatLog(message, properties),
      error: error,
      stackTrace: stackTrace,
      properties: properties,
    );
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

    _fileLogger?.error(
      _formatLog(message, properties),
      error: error,
      stackTrace: stackTrace,
      properties: properties,
    );

    _crashReportLogger?.error(
      _formatLog(message, properties),
      error: error,
      stackTrace: stackTrace,
      properties: properties,
    );
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

    logMessage += '[$_baseContext]';

    if (properties != null) {
      final jsonProperties = jsonEncode(properties);

      logMessage += '\n - [Properties] = $jsonProperties';
    }

    return logMessage;
  }
}

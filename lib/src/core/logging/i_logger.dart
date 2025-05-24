import 'dart:convert';

import 'package:meta/meta.dart';

/// A Logger class to log any necessary messages or errors
abstract class ILogger {
  // ignore: public_member_api_docs
  const ILogger();

  /// This log will only be logged to the console & optionally to a local file with DEBUG level
  void debug(
    /// Required message that will be appended to the log information
    String message, {
    /// Optional map with properties that can be a key-value pair of relevant information for the log
    /// that will be encoded in JSON format and appended at the end of the message
    Map<String, String?>? properties,
  });

  /// This log will be logged with INFO level
  void info(
    /// Required message that will be appended to the log information
    String message, {
    /// Optional map with properties that can be a key-value pair of relevant information for the log
    /// that will be encoded in JSON format and appended at the end of the message
    Map<String, String?>? properties,
  });

  /// This log will be logged with WARNING level
  void warning(
    /// Required message that will be appended to the log information
    String message, {
    /// (Optional) The error that happened. Ideally it should be descriptive enough & point to a specific part of the code
    Object? error,

    /// (Optional) The stack trace that originated this error. If logging is being done outside a try-catch use **StackTrace.current**
    StackTrace? stackTrace,

    /// (Optional) map with properties that can be a key-value pair of relevant information for the log
    /// that will be encoded in JSON format and appended at the end of the message
    Map<String, String?>? properties,
  });

  /// Error logs are used to inform that an error ocurred that should be notified to the development team
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
  });

  /// Formats the properties of the log message
  ///
  /// It will append the properties to the message in a JSON format
  ///
  /// Example:
  /// ```dart
  /// final message = "User logged in";
  /// final properties = {"userId": "123", "email": "user@example.com"};
  /// final formattedMessage = formatProperties(message, properties);
  /// ```
  ///
  /// Output:
  /// ```text
  /// User logged in
  ///  - [Properties] = {"userId":"123","email":"user@example.com"}
  /// ```
  @protected
  String formatProperties(String message, Map<String, dynamic>? properties) {
    var formattedMessage = message;

    if (properties != null) {
      final jsonProperties = jsonEncode(properties);
      formattedMessage += '\n - [Properties] = $jsonProperties';
    }

    return formattedMessage;
  }
}

/// A Logger class to log any necessary messages or errors
abstract class ILogger {
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
}

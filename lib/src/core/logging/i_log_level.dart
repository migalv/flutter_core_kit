import 'package:talker/talker.dart';

enum ILogLevel {
  debug,
  info,
  warning,
  error;

  LogLevel toTalker() => switch (this) {
        ILogLevel.debug => LogLevel.debug,
        ILogLevel.info => LogLevel.info,
        ILogLevel.warning => LogLevel.warning,
        ILogLevel.error => LogLevel.error,
      };
}

import 'package:rxdart/rxdart.dart';

/// Helpful extensions on [Stream]
extension StreamX<T> on Stream<T> {
  /// Subscibe to the [CompositeSubscription] safely
  ///```dart
  /// stream.listenSafe(compositeSubscription, onData: (event) {});
  /// ```
  void listenSafe(
    CompositeSubscription compositeSubscription, {
    void Function(T event)? onData,
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    compositeSubscription.add(
      listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      ),
    );
  }
}

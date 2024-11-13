/// Interface to make a class disposable
abstract class IDisposable {
  /// Dispose the service
  Future<void> dispose();
}

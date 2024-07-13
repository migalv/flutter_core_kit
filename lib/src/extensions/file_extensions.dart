import 'dart:io';

/// Set of useful helper methods for the [File] class
extension FileX on File {
  /// Get the file name for this [File]
  ///
  /// It returns null if something went wrong
  String? get fileName {
    final parts = path.split('/');

    if (parts.isEmpty) {
      return null;
    }

    return parts.last;
  }
}

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// A generic data source implementation that provides in-memory caching capabilities
/// for CRUD operations. This class automatically handles cache invalidation and updates
/// after any mutation operation (create, update, delete).
///
/// Type parameter [T] represents the model class being cached.
///
/// The cache is implemented using a [BehaviorSubject] which maintains the latest state
/// and allows reactive updates through stream observation.
abstract class MemoryCacheDatasource<T> {
  /// Internal cache implementation using [BehaviorSubject].
  /// Initialized with an empty list as the seed value.
  /// This subject maintains the latest state of the data and broadcasts updates
  /// to all active observers.
  final BehaviorSubject<List<T>> _cache = BehaviorSubject.seeded([]);

  /// Returns a [Stream] of cached items that can be observed for real-time updates.
  ///
  /// If the cache doesn't have any value (first access), it automatically triggers
  /// a refresh to populate the cache before returning the stream.
  ///
  /// This is particularly useful for UI components that need to react to data changes,
  /// such as StreamBuilder widgets.
  Stream<List<T>> observeItems() {
    if (!_cache.hasValue) {
      refresh();
    }

    return _cache.stream.whereNotNull().distinct();
  }

  /// Creates a new item in the data source.
  ///
  /// Implementations should handle the actual creation of the item in the underlying
  /// data source (e.g., API, database).
  ///
  /// [item] The item to be created
  /// Returns the created item, which may contain additional server-generated fields
  @protected
  Future<T> executeCreate(T item);

  /// Retrieves all items from the data source.
  ///
  /// Implementations should handle the actual data fetching from the underlying
  /// data source (e.g., API, database).
  ///
  /// Returns a list of all available items
  @protected
  Future<List<T>> executeRead();

  /// Updates an existing item in the data source.
  ///
  /// Implementations should handle the actual update operation in the underlying
  /// data source (e.g., API, database).
  ///
  /// [item] The item to be updated with its new values
  /// Returns the updated item, which may contain additional server-generated fields
  @protected
  Future<T> executeUpdate(T item);

  /// Deletes an item from the data source.
  ///
  /// Implementations should handle the actual deletion in the underlying
  /// data source (e.g., API, database).
  ///
  /// [item] The item to be deleted
  @protected
  Future<void> executeDelete(T item);

  /// Creates a new item and automatically refreshes the cache.
  ///
  /// This method coordinates the creation operation and cache update:
  /// 1. Executes the create operation in the underlying data source
  /// 2. Refreshes the cache to reflect the new state
  /// 3. Returns the created item
  ///
  /// [item] The item to be created
  /// Returns the created item
  Future<T> create(T item) async {
    final createdItem = await executeCreate(item);
    await refresh();
    return createdItem;
  }

  /// Retrieves all items, using cached data if available.
  ///
  /// If the cache is empty (first access), it triggers a refresh to populate
  /// the cache before returning the data.
  ///
  /// Returns a list of all items, either from cache or freshly fetched
  Future<List<T>> get() async {
    if (!_cache.hasValue) {
      await refresh();
    }
    return _cache.value;
  }

  /// Updates an existing item and automatically refreshes the cache.
  ///
  /// This method coordinates the update operation and cache update:
  /// 1. Executes the update operation in the underlying data source
  /// 2. Refreshes the cache to reflect the new state
  /// 3. Returns the updated item
  ///
  /// [item] The item to be updated
  /// Returns the updated item
  Future<T> update(T item) async {
    final updatedItem = await executeUpdate(item);
    await refresh();
    return updatedItem;
  }

  /// Deletes an item and automatically refreshes the cache.
  ///
  /// This method coordinates the deletion operation and cache update:
  /// 1. Executes the delete operation in the underlying data source
  /// 2. Refreshes the cache to reflect the new state
  ///
  /// [item] The item to be deleted
  Future<void> delete(T item) async {
    await executeDelete(item);
    await refresh();
  }

  /// Forces a refresh of the cache by fetching fresh data from the data source.
  ///
  /// This method can be called manually when you need to ensure the cache
  /// is synchronized with the data source, even if no mutations have occurred.
  Future<void> refresh() async {
    final items = await executeRead();
    _cache.add(items);
  }

  /// Clears all cached data.
  ///
  /// This is particularly useful during user sign-out or when you need to
  /// invalidate the entire cache without fetching new data.
  void clearCache() {
    _cache.add([]);
  }

  /// Releases all resources held by the cache.
  ///
  /// This should be called when the data source is no longer needed to prevent
  /// memory leaks. Typically called in dispose() methods of State objects or
  /// when cleaning up dependency injection containers.
  void dispose() {
    _cache.close();
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storiesStoreHash() => r'8a719a5276ca9529396b5c96da47f0aacbec878a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$StoriesStore
    extends BuildlessAutoDisposeAsyncNotifier<List<Story>> {
  late final int userId;

  FutureOr<List<Story>> build(
    int userId,
  );
}

/// See also [StoriesStore].
@ProviderFor(StoriesStore)
const storiesStoreProvider = StoriesStoreFamily();

/// See also [StoriesStore].
class StoriesStoreFamily extends Family<AsyncValue<List<Story>>> {
  /// See also [StoriesStore].
  const StoriesStoreFamily();

  /// See also [StoriesStore].
  StoriesStoreProvider call(
    int userId,
  ) {
    return StoriesStoreProvider(
      userId,
    );
  }

  @override
  StoriesStoreProvider getProviderOverride(
    covariant StoriesStoreProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'storiesStoreProvider';
}

/// See also [StoriesStore].
class StoriesStoreProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StoriesStore, List<Story>> {
  /// See also [StoriesStore].
  StoriesStoreProvider(
    int userId,
  ) : this._internal(
          () => StoriesStore()..userId = userId,
          from: storiesStoreProvider,
          name: r'storiesStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$storiesStoreHash,
          dependencies: StoriesStoreFamily._dependencies,
          allTransitiveDependencies:
              StoriesStoreFamily._allTransitiveDependencies,
          userId: userId,
        );

  StoriesStoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  FutureOr<List<Story>> runNotifierBuild(
    covariant StoriesStore notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(StoriesStore Function() create) {
    return ProviderOverride(
      origin: this,
      override: StoriesStoreProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StoriesStore, List<Story>>
      createElement() {
    return _StoriesStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoriesStoreProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StoriesStoreRef on AutoDisposeAsyncNotifierProviderRef<List<Story>> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _StoriesStoreProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StoriesStore, List<Story>>
    with StoriesStoreRef {
  _StoriesStoreProviderElement(super.provider);

  @override
  int get userId => (origin as StoriesStoreProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

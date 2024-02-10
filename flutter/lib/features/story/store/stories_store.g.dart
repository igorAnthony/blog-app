// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storiesStoreHash() => r'f349c5bbe9e33aa402e26389cc2aef74660230b5';

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
    extends BuildlessAutoDisposeAsyncNotifier<List<ListStory>> {
  late final User user;

  FutureOr<List<ListStory>> build(
    User user,
  );
}

/// See also [StoriesStore].
@ProviderFor(StoriesStore)
const storiesStoreProvider = StoriesStoreFamily();

/// See also [StoriesStore].
class StoriesStoreFamily extends Family<AsyncValue<List<ListStory>>> {
  /// See also [StoriesStore].
  const StoriesStoreFamily();

  /// See also [StoriesStore].
  StoriesStoreProvider call(
    User user,
  ) {
    return StoriesStoreProvider(
      user,
    );
  }

  @override
  StoriesStoreProvider getProviderOverride(
    covariant StoriesStoreProvider provider,
  ) {
    return call(
      provider.user,
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
class StoriesStoreProvider extends AutoDisposeAsyncNotifierProviderImpl<
    StoriesStore, List<ListStory>> {
  /// See also [StoriesStore].
  StoriesStoreProvider(
    User user,
  ) : this._internal(
          () => StoriesStore()..user = user,
          from: storiesStoreProvider,
          name: r'storiesStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$storiesStoreHash,
          dependencies: StoriesStoreFamily._dependencies,
          allTransitiveDependencies:
              StoriesStoreFamily._allTransitiveDependencies,
          user: user,
        );

  StoriesStoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.user,
  }) : super.internal();

  final User user;

  @override
  FutureOr<List<ListStory>> runNotifierBuild(
    covariant StoriesStore notifier,
  ) {
    return notifier.build(
      user,
    );
  }

  @override
  Override overrideWith(StoriesStore Function() create) {
    return ProviderOverride(
      origin: this,
      override: StoriesStoreProvider._internal(
        () => create()..user = user,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        user: user,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StoriesStore, List<ListStory>>
      createElement() {
    return _StoriesStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoriesStoreProvider && other.user == user;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, user.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StoriesStoreRef on AutoDisposeAsyncNotifierProviderRef<List<ListStory>> {
  /// The parameter `user` of this provider.
  User get user;
}

class _StoriesStoreProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StoriesStore,
        List<ListStory>> with StoriesStoreRef {
  _StoriesStoreProviderElement(super.provider);

  @override
  User get user => (origin as StoriesStoreProvider).user;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsStoreHash() => r'6b4d53ecece4727d9e3a95955b60140b4f19e589';

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

abstract class _$PostsStore
    extends BuildlessAutoDisposeAsyncNotifier<List<Post>> {
  late final int? categoryId;

  FutureOr<List<Post>> build({
    int? categoryId,
  });
}

/// See also [PostsStore].
@ProviderFor(PostsStore)
const postsStoreProvider = PostsStoreFamily();

/// See also [PostsStore].
class PostsStoreFamily extends Family<AsyncValue<List<Post>>> {
  /// See also [PostsStore].
  const PostsStoreFamily();

  /// See also [PostsStore].
  PostsStoreProvider call({
    int? categoryId,
  }) {
    return PostsStoreProvider(
      categoryId: categoryId,
    );
  }

  @override
  PostsStoreProvider getProviderOverride(
    covariant PostsStoreProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
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
  String? get name => r'postsStoreProvider';
}

/// See also [PostsStore].
class PostsStoreProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PostsStore, List<Post>> {
  /// See also [PostsStore].
  PostsStoreProvider({
    int? categoryId,
  }) : this._internal(
          () => PostsStore()..categoryId = categoryId,
          from: postsStoreProvider,
          name: r'postsStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsStoreHash,
          dependencies: PostsStoreFamily._dependencies,
          allTransitiveDependencies:
              PostsStoreFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  PostsStoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int? categoryId;

  @override
  FutureOr<List<Post>> runNotifierBuild(
    covariant PostsStore notifier,
  ) {
    return notifier.build(
      categoryId: categoryId,
    );
  }

  @override
  Override overrideWith(PostsStore Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostsStoreProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostsStore, List<Post>>
      createElement() {
    return _PostsStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostsStoreProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostsStoreRef on AutoDisposeAsyncNotifierProviderRef<List<Post>> {
  /// The parameter `categoryId` of this provider.
  int? get categoryId;
}

class _PostsStoreProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostsStore, List<Post>>
    with PostsStoreRef {
  _PostsStoreProviderElement(super.provider);

  @override
  int? get categoryId => (origin as PostsStoreProvider).categoryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

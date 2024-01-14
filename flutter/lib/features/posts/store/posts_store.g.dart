// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsStoreHash() => r'2683adeee69a1d05f7bcb027080fc417e46eb7c3';

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
  late final int? userId;

  FutureOr<List<Post>> build({
    int? categoryId,
    int? userId,
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
    int? userId,
  }) {
    return PostsStoreProvider(
      categoryId: categoryId,
      userId: userId,
    );
  }

  @override
  PostsStoreProvider getProviderOverride(
    covariant PostsStoreProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      userId: provider.userId,
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
    int? userId,
  }) : this._internal(
          () => PostsStore()
            ..categoryId = categoryId
            ..userId = userId,
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
          userId: userId,
        );

  PostsStoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.userId,
  }) : super.internal();

  final int? categoryId;
  final int? userId;

  @override
  FutureOr<List<Post>> runNotifierBuild(
    covariant PostsStore notifier,
  ) {
    return notifier.build(
      categoryId: categoryId,
      userId: userId,
    );
  }

  @override
  Override overrideWith(PostsStore Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostsStoreProvider._internal(
        () => create()
          ..categoryId = categoryId
          ..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        userId: userId,
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
    return other is PostsStoreProvider &&
        other.categoryId == categoryId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostsStoreRef on AutoDisposeAsyncNotifierProviderRef<List<Post>> {
  /// The parameter `categoryId` of this provider.
  int? get categoryId;

  /// The parameter `userId` of this provider.
  int? get userId;
}

class _PostsStoreProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostsStore, List<Post>>
    with PostsStoreRef {
  _PostsStoreProviderElement(super.provider);

  @override
  int? get categoryId => (origin as PostsStoreProvider).categoryId;
  @override
  int? get userId => (origin as PostsStoreProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

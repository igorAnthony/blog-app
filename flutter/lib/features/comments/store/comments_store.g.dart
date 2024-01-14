// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentsStoreHash() => r'cd5f8bdffb29d685b6b6931bc4e9a42de68c3533';

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

abstract class _$CommentsStore
    extends BuildlessAutoDisposeAsyncNotifier<List<Comment>> {
  late final int postId;

  FutureOr<List<Comment>> build(
    int postId,
  );
}

/// See also [CommentsStore].
@ProviderFor(CommentsStore)
const commentsStoreProvider = CommentsStoreFamily();

/// See also [CommentsStore].
class CommentsStoreFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentsStore].
  const CommentsStoreFamily();

  /// See also [CommentsStore].
  CommentsStoreProvider call(
    int postId,
  ) {
    return CommentsStoreProvider(
      postId,
    );
  }

  @override
  CommentsStoreProvider getProviderOverride(
    covariant CommentsStoreProvider provider,
  ) {
    return call(
      provider.postId,
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
  String? get name => r'commentsStoreProvider';
}

/// See also [CommentsStore].
class CommentsStoreProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CommentsStore, List<Comment>> {
  /// See also [CommentsStore].
  CommentsStoreProvider(
    int postId,
  ) : this._internal(
          () => CommentsStore()..postId = postId,
          from: commentsStoreProvider,
          name: r'commentsStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentsStoreHash,
          dependencies: CommentsStoreFamily._dependencies,
          allTransitiveDependencies:
              CommentsStoreFamily._allTransitiveDependencies,
          postId: postId,
        );

  CommentsStoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final int postId;

  @override
  FutureOr<List<Comment>> runNotifierBuild(
    covariant CommentsStore notifier,
  ) {
    return notifier.build(
      postId,
    );
  }

  @override
  Override overrideWith(CommentsStore Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentsStoreProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CommentsStore, List<Comment>>
      createElement() {
    return _CommentsStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentsStoreProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CommentsStoreRef on AutoDisposeAsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _CommentsStoreProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentsStore,
        List<Comment>> with CommentsStoreRef {
  _CommentsStoreProviderElement(super.provider);

  @override
  int get postId => (origin as CommentsStoreProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

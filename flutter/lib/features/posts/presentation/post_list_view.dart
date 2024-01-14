import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/card_post_widget.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListView extends ConsumerWidget {
  final int? categoryId;

  const PostListView({this.categoryId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postRef = ref.watch(postsStoreProvider(categoryId: categoryId));
    return SingleChildScrollView(
      child: SizedBox(
        height: categoryId == null ? MediaQuery.of(context).size.height - 450 : MediaQuery.of(context).size.height - 100,
        child: ListView.builder(
          itemCount: postRef.value?.length ?? 0,
          itemBuilder: (context, index) {
            return CardPostWidget(
              post: postRef.value?[index] ?? Post(), 
              onLikeDislike: (postId) {
                if(postRef.value != null ) ref.read(postsStoreProvider().notifier).likeDislikePost(index);
              },
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/card_post_widget.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_blog_app/features/posts/widgets/no_data_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListWidget extends ConsumerStatefulWidget {
  final int? categoryId;
  final int? userId;
  final List<Post> posts;

  const PostListWidget({this.categoryId, this.userId, required this.posts, super.key});

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends ConsumerState<PostListWidget> {
  @override
  Widget build(BuildContext context) {
    
    final postRef = ref.watch(postsStoreProvider(categoryId: widget.categoryId, userId: widget.userId));
    return (postRef.value?.length ?? 0) > 0 ? SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: postRef.value?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: CardPostWidget(
              post: postRef.value?[index] ?? Post(), 
              onLikeDislike: (postId) {
                if(postRef.value != null ) ref.read(postsStoreProvider().notifier).likeDislikePost(index);
              },
            ),
          );
        },
      ),
    ): const NoDataWidget();
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/posts/presentation/post_detail_view.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/card_post_widget.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListWidget extends ConsumerStatefulWidget {
  final int? categoryId;
  final int? userId;

  const PostListWidget({this.categoryId, this.userId, super.key});

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends ConsumerState<PostListWidget> {
  @override
  Widget build(BuildContext context) {
    
    final postRef = ref.watch(postsStoreProvider(categoryId: widget.categoryId, userId: widget.userId));
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
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
      ),
    );
  }
}
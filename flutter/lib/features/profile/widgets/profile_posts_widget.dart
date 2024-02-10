import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_blog_app/features/posts/widgets/post_list_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePostsWidget extends ConsumerStatefulWidget {
  final List<Post> posts;
  const ProfilePostsWidget({required this.posts, super.key});

  @override
  _ProfilePostsWidgetState createState() => _ProfilePostsWidgetState();
}

class _ProfilePostsWidgetState extends ConsumerState<ProfilePostsWidget> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStoreProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PostListWidget(userId: user.asData!.value.id, posts: widget.posts)
      ],
    );
  }
}
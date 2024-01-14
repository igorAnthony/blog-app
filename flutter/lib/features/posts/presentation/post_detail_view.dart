import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';

class PostDetailView extends StatelessWidget {
  final Post post;
  const PostDetailView(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${post.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${post.title}', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 24)),
                  const SizedBox(height: 10),
                  Text('${post.body}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black, fontSize: 18)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${post.user?.name}', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 18)),
                      Text('${post.createdAt}', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
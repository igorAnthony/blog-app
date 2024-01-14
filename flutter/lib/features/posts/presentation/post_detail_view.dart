import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_quill/flutter_quill.dart';

class PostDetailView extends StatelessWidget {
  final Post post;
  const PostDetailView(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    final QuillController _textEditorController = QuillController.basic();
    _textEditorController.document = Document.fromJson(post.body!);

    return Scaffold(
      appBar: AppBar(),
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
                  QuillEditor.basic(configurations: QuillEditorConfigurations(
                    readOnly: true,
                    controller: _textEditorController,
                    scrollable: true,
                    autoFocus: false,
                    enableInteractiveSelection: false,
                    showCursor: false,
                    ),
                  ),
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
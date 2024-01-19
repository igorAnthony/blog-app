import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/presentation/opened_story_view.dart';

class UserStoryNavigationView extends StatefulWidget {
  const UserStoryNavigationView({super.key});

  @override
  State<UserStoryNavigationView> createState() => _UserStoryNavigationViewState();
}

class _UserStoryNavigationViewState extends State<UserStoryNavigationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return OpenedStoryView(
          imageUrl: 'https://picsum.photos/200/300?random=$index',
          name: 'User $index',
          avatarUrl: 'https://picsum.photos/200/300?random=$index',
        );
          
      },
    );
  }
}
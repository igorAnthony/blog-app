import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/presentation/user_story_navigation_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoryNavigation extends ConsumerStatefulWidget {
  final int firstIndex;
  StoryNavigation(this.firstIndex, {super.key});

  @override
  _StoryNavigationState createState() => _StoryNavigationState();
}

class _StoryNavigationState extends ConsumerState<StoryNavigation> {

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(initialPage: widget.firstIndex),
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return UserStoryNavigationView();
      },
    );
  }
}
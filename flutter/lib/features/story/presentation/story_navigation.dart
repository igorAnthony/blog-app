import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/features/story/model/list_story_model.dart';
import 'package:flutter_blog_app/features/story/model/story_model.dart';
import 'package:flutter_blog_app/features/story/presentation/one_user_story_navigation_view.dart';
import 'package:flutter_blog_app/features/story/store/stories_store.dart';
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
    final userRef = ref.read(userStoreProvider);
    final storyRef = ref.watch(storiesStoreProvider(userRef.value!));
    // return PageView.builder(
    //   controller: PageController(initialPage: widget.firstIndex),
    //   scrollDirection: Axis.horizontal,
    //   itemCount: storyRef.value?.length ?? 0,
    //   itemBuilder: (context, index) {
    //     List<Story> stories = storyRef.value![index];
    //     return OneUserStoryNavigationView(stories); 
    //   },
    // );

      return CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, realIndex) {
          ListStory stories = storyRef.value![index];
          return OneUserStoryNavigationView(stories);
        },
        options: CarouselOptions(
          autoPlay: false,
          height: MediaQuery.of(context).size.height,
          scrollDirection: Axis.horizontal
        ));
  }
}
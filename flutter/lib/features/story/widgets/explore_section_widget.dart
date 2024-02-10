import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/model/story_model.dart';
import 'package:flutter_blog_app/features/story/presentation/one_user_story_navigation_view.dart';
import 'package:flutter_blog_app/features/story/widgets/user_avatar_story_widget.dart';
import 'package:flutter_blog_app/features/story/model/list_story_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreSection extends ConsumerWidget {
  final List<ListStory> listStories;
  const ExploreSection({required this.listStories, super.key});

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Explore today's", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          //horizontal list show a list of users
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listStories.length,
              itemBuilder: (context, index) {
                ListStory stories = listStories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OneUserStoryNavigationView(stories)
                      ),
                    );
                  },
                  child: UserStoryWidget(
                    story: ListStory(
                      name: stories.name,
                      avatar: stories.avatar,
                      stories: stories.stories,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

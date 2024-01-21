import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/presentation/one_user_story_navigation_view.dart';
import 'package:flutter_blog_app/features/story/presentation/story_navigation.dart';
import 'package:flutter_blog_app/features/story/store/stories_store.dart';
import 'package:flutter_blog_app/features/story/widgets/user_avatar_story_widget.dart';
import 'package:flutter_blog_app/features/story/model/story_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreSection extends ConsumerWidget {
  const ExploreSection({super.key});

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
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                List<Story> stories = ref.read(storiesStoreProvider(index)).value?[index] ?? [];
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
                    story: Story(
                      name: 'User $index',
                      imageUrl: 'https://picsum.photos/200/300?random=$index',
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

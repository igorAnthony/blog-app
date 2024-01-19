import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/presentation/story_navigation.dart';
import 'package:flutter_blog_app/features/story/widgets/user_avatar_story_widget.dart';
import 'package:flutter_blog_app/features/story/model/story_model.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryNavigation(index)
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

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/story_widget.dart';
import 'package:flutter_blog_app/models/story.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text("Explore today's", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          //horizontal list show a list of users
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return UserStoryWidget(
                  story: Story(
                    name: 'User $index',
                    imageUrl: 'https://picsum.photos/200/300?random=$index',
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

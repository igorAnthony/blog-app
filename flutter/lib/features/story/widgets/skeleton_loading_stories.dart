import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/widgets/user_avatar_story_widget.dart';
import 'package:flutter_blog_app/features/story/model/list_story_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoadingExploreSection extends ConsumerWidget {
  const SkeletonLoadingExploreSection({super.key});

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Explore today's", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: UserStoryWidget(
                      story: ListStory(
                        name: '',
                        avatar: '',
                        stories: [],
                      ),)
                  ),
                );
              },
            ),
            
          )
        ],
      ),
    );
  }
}



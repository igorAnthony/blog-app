import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/story_model.dart';

class UserStoryWidget extends StatelessWidget {
  final Story story;

  const UserStoryWidget({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.amber,
            image: story.imageUrl != null
                ? DecorationImage(
                    image: NetworkImage('${story.imageUrl}'),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.center,
          child: Text(
            '${story.name}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
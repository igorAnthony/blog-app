import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/model/list_story_model.dart';

class UserStoryWidget extends StatefulWidget {
  final ListStory story;

  const UserStoryWidget({
    super.key,
    required this.story,
  });

  @override
  State<UserStoryWidget> createState() => _UserStoryWidgetState();
}

class _UserStoryWidgetState extends State<UserStoryWidget> {
  @override

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(2),
          width: 65, // Aumente o tamanho do container externo
          height: 65, // Aumente o tamanho do container externo
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [
                //creaate a harmonius gradient
                Colors.purple,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
              ], // Adicione as cores do gradiente aqui
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            width: 60, // Tamanho original do container
            height: 60, // Tamanho original do container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.grey,
              border: Border.all(
                width: 4,
                color: Colors.white,
              ),
              image: widget.story.avatar != '' && widget.story.avatar != null ? DecorationImage(
                image: NetworkImage('${widget.story.avatar}'),
                fit: BoxFit.cover,
              ) : null,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.center,
          child: Text(
            '',
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
import 'package:flutter/material.dart';

class StoryView extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? avatarUrl;

  const StoryView({
    required this.imageUrl,
    required this.name,
    required this.avatarUrl,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber,
                      image: avatarUrl != null
                          ? DecorationImage(
                              image: NetworkImage('$avatarUrl'),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$name',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
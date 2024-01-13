import 'package:flutter/material.dart';

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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.amber),
                    ),
                    const SizedBox(height: 5),
                    Align(
                        alignment: Alignment.center,
                        child: Text('User $index',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

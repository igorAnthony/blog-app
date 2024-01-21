import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/story/model/story_model.dart';
import 'package:flutter_blog_app/features/story/presentation/opened_story_view.dart';

class OneUserStoryNavigationView extends StatefulWidget {
  List<Story> stories;
  String? avatarUrl;
  OneUserStoryNavigationView(this.stories, {this.avatarUrl, super.key});

  @override
  State<OneUserStoryNavigationView> createState() => _OneUserStoryNavigationViewViewState();
}

class _OneUserStoryNavigationViewViewState extends State<OneUserStoryNavigationView>
    with SingleTickerProviderStateMixin {
  double currentPageValue = 0.0;
  int lastIndex = 0;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //List<Story> stories = widget.stories;
    // return PageView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: stories.length,
    //   itemBuilder: (context, index) {
    //     return OpenedStoryView(
    //       imageUrl: 'https://picsum.photos/200/300?random=$index',
    //       name: 'User $index',
    //       avatarUrl: 'https://picsum.photos/200/300?random=$index',
    //     );
          
    //   },
    // );
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              if (lastIndex == 2) { // 2 is the last index
                Navigator.of(context).pop();
              }
              return OpenedStoryView(
                imageUrl: 'https://picsum.photos/200/300?random=$index',
                name: 'User $index',
                avatarUrl: 'https://picsum.photos/200/300?random=$index',
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              height: MediaQuery.of(context).size.height,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPageValue = index.toDouble();

                });
                
              },
            )),
            Positioned(
              top: 70,
              left: 20,
              right: 20,
              child: LinearProgressIndicator(
                value: currentPageValue / 10, // 10 is the itemCount of PageView.builder
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
        ],
      ),
    );
  }
}
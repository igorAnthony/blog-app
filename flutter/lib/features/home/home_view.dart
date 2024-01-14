import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/categories/category_store.dart';
import 'package:flutter_blog_app/features/posts/presentation/post_list_view.dart';
import 'package:flutter_blog_app/features/posts/presentation/post_list_view_with_tabs.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/explore_section_widget.dart';
import 'package:flutter_blog_app/features/posts/widgets/header_content_widget.dart';
import 'package:flutter_blog_app/features/posts/widgets/card_post_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int? userId = 0;

  @override
  Widget build(BuildContext context) {
    final postRef = ref.watch(postsStoreProvider());


    return postRef.asData?.isLoading ?? true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: const Color.fromARGB(255, 253, 250, 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderContent(),
                const ExploreSection(),
                RefreshIndicator(
                  onRefresh: () {
                    return ref.read(postsStoreProvider().notifier).getPosts(); 
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              const Text("Latest News",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500)),
                              kTextButton('More', () {
                                final categories = ref.watch(categoriesStoreProvider);
                                categories.whenData((value) =>
                                    Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TabsWithPostListView(categories: value),
                                    ),
                                  )
                                );                                
                              }, style: Theme.of(context).textTheme.titleSmall!)
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        PostListView()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

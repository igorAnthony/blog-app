import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/categories/category_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/post_list_widget.dart';
import 'package:flutter_blog_app/features/posts/presentation/post_list_view.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/explore_section_widget.dart';
import 'package:flutter_blog_app/features/posts/widgets/header_content_widget.dart';
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
            height: MediaQuery.of(context).size.height,
            width: double.maxFinite,
            color: const Color.fromARGB(255, 253, 250, 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderContent(),
                const ExploreSection(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Latest News",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                      kTextButton('More', () {
                        final categories = ref.watch(categoriesStoreProvider);
                        categories
                            .whenData((value) => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostListView(categories: value),
                                  ),
                                ));
                      }, style: Theme.of(context).textTheme.titleSmall!)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: const PostListWidget()
                  )
                )
              ],
            ),
          );
  }
}
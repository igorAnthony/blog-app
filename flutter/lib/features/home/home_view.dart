import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/features/categories/category_store.dart';
import 'package:flutter_blog_app/features/categories/widget/carousel_categories_widget.dart';
import 'package:flutter_blog_app/features/categories/widget/skeleton_loading_carousel_categories.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/post_list_widget.dart';
import 'package:flutter_blog_app/features/posts/widgets/skeleton_loading_post_list_widget.dart';
import 'package:flutter_blog_app/features/story/widgets/explore_section_widget.dart';
import 'package:flutter_blog_app/features/posts/widgets/header_content_widget.dart';
import 'package:flutter_blog_app/features/story/store/stories_store.dart';
import 'package:flutter_blog_app/features/story/widgets/skeleton_loading_stories.dart';
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
    final user = ref.read(userStoreProvider);
    final storiesStore = ref.watch(storiesStoreProvider(user.value!));
    final categoriesStore = ref.watch(categoriesStoreProvider);
    final postsStore = ref.watch(postsStoreProvider(categoryId: null, userId: null));
    final isStoriesLoading = ref.watch(storiesStoreProvider(user.value!).select((value) => value.value == null));
    final isCategoriesStoreLoading = ref.watch(categoriesStoreProvider.select((value) => value.value == null));
    final isPostsStoreLoading = ref.watch(postsStoreProvider(categoryId: null, userId: null).select((value) => value.value == null));

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderContent(),
          (isStoriesLoading || isCategoriesStoreLoading || isPostsStoreLoading) ?  const SkeletonLoadingExploreSection() : ExploreSection(listStories: storiesStore.value ?? []),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: (isStoriesLoading || isCategoriesStoreLoading || isPostsStoreLoading) ?  const SkeletonLoadingCarouselCategories() : CarouselCategories(categories: categoriesStore.value ?? [])
          ),
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
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>  PostListView(posts:posts, categories: categories)),
                  // );
                }, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(child: Container(
            margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: (isStoriesLoading || isCategoriesStoreLoading || isPostsStoreLoading) ? const SkeletonLoadingPostList() : PostListWidget(posts: postsStore.value ?? []),
            )
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/categories/category_model.dart';
import 'package:flutter_blog_app/features/posts/presentation/post_list_view.dart';

class TabsWithPostListView extends StatefulWidget {
  final List<Category> categories;
  const TabsWithPostListView({required this.categories, super.key});

  @override
  _TabsWithPostListViewState createState() => _TabsWithPostListViewState();
}

class _TabsWithPostListViewState extends State<TabsWithPostListView>
    with TickerProviderStateMixin {
    late TabController _tabController;
    int selectedTabIndex = 0;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(vsync: this, length: widget.categories.length, initialIndex: selectedTabIndex);
    }
  @override
  Widget build(BuildContext context) {

    
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          width: double.maxFinite,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).hintColor,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                tabs: List.generate(
                  widget.categories.length,
                  (index) => Text(widget.categories[index].name),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    widget.categories.length,
                    (index) => Center(
                      child: PostListView(
                        categoryId: widget.categories[index].id,
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
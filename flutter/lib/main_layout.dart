import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/features/categories/category_model.dart';
import 'package:flutter_blog_app/features/categories/category_store.dart';
import 'package:flutter_blog_app/features/home/home_view.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/profile/presentation/profile_view.dart';
import 'package:flutter_blog_app/features/story/model/list_story_model.dart';
import 'package:flutter_blog_app/features/story/store/stories_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userStore = ref.read(userStoreProvider);
    final user = userStore.value!;
    return Scaffold(
      body: currentIndex == 0
          ? const SafeArea(child: HomeView())
          : SafeArea(child: ProfileView(user: user)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkBlueColor,
        foregroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Adicionar Story'),
              onTap: () {
                //
              },
            ),
            ListTile(
              leading: Icon(Icons.post_add),
              title: Text('Criar Post'),
              onTap: () {
                navigatorPushNamed(context, createPostRoute);
              },
            ),
          ],
        );
      },
    );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.darkBlueColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Perfil'),
        ],
        currentIndex: currentIndex,
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
      ),
    );
  }
}

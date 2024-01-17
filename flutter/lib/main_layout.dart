import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/features/home/home_view.dart';
import 'package:flutter_blog_app/features/profile/presentation/profile_view.dart';
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
    
    return Scaffold(
      body: currentIndex == 0
          ? const SafeArea(child: HomeView())
          : const SafeArea(child: ProfileView()),
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
                // Adicione a ação que você deseja realizar quando o botão for pressionado
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.post_add),
              title: Text('Criar Post'),
              onTap: () {
                navigatorPushNamed(context, createPostRoute);
                Navigator.pop(context);
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

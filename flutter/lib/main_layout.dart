import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/home/home_view.dart';
import 'package:flutter_blog_app/features/profile/profile_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 ? const SafeArea(child: HomeView()) : const SafeArea(child: ProfileView()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkBlueColor,
        foregroundColor: Colors.white,
        onPressed:() {
          navigatorPushNamed(context, createPostRoute);
        },
        child: const Icon(Icons.add, size: 30,), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.darkBlueColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size:30),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30,),
              label: 'Perfil'
            ),
          ],
          currentIndex: currentIndex,
          onTap: (val){
            setState(() {
              currentIndex = val;
            });
          },
        ),
      );
  }
}
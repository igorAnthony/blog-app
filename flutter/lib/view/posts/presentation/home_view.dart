import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/view/posts/presentation/post_view.dart';
import 'package:flutter_blog_app/view/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 ? const SafeArea(child: PostView()) : const SafeArea(child: ProfileView()),
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
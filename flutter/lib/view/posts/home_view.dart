import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:flutter_blog_app/view/posts/create_post_view.dart';
import 'package:flutter_blog_app/view/posts/post_view.dart';
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
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed:() {
                logout().then((value) => navigatorPushNamedAndRemoveUntil(context, loginRoute));
            }, 
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: currentIndex == 0 ? const PostView() : const ProfileView(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigatorPushNamed(context, createPostRoute);
        },
        child: const Icon(Icons.add, size: 30,), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top:14.0),
                child: Icon(Icons.home, size:30),
              ),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top:14.0),
                child: Icon(Icons.person, size: 30,),
              ),
              label: ''
            ),
          ],
          currentIndex: currentIndex,
          onTap: (val){
            setState(() {
              currentIndex = val;
            });
          },
        ),
      ),
    );
  }
}
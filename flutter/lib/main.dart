

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/constant/themes.dart';
import 'package:flutter_blog_app/view/loading_view.dart';
import 'package:flutter_blog_app/view/login_view.dart';
import 'package:flutter_blog_app/view/posts/presentation/create_post_view.dart';
import 'package:flutter_blog_app/view/posts/presentation/home_view.dart';
import 'package:flutter_blog_app/view/posts/presentation/post_view.dart';
import 'package:flutter_blog_app/view/register_view.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter blog-app',
      theme: ThemeData(
        primaryColor: AppColors.darkBlueColor,
        textTheme: AppThemes.textTheme1,
      ),
      home: const LoadingView(),
      darkTheme: ThemeData.dark(),
      routes: 
        {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          homeRoute: (context) => const HomeView(),
          postRoute: (context) => const PostView(),
          createPostRoute: (context) => const CreatePostView(),
        }
    ));
}



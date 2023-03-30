import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/view/home_view.dart';
import 'package:flutter_blog_app/view/loading_view.dart';
import 'package:flutter_blog_app/view/login_view.dart';
import 'package:flutter_blog_app/view/register_view.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter blog-app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoadingView(),
      routes: 
        {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          homeRoute: (context) => const HomeView(),
        }
    ));
}



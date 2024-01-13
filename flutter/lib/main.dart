

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/constant/themes.dart';
import 'package:flutter_blog_app/features/auth/presentation/login_view.dart';
import 'package:flutter_blog_app/features/utils/loading_view.dart';
import 'package:flutter_blog_app/features/posts/presentation/create_post_view.dart';
import 'package:flutter_blog_app/dashboard_view.dart';
import 'package:flutter_blog_app/features/home/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/presentation/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: _BlogApp()));
}

class _BlogApp extends ConsumerWidget{
  const _BlogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter blog-app',
      theme: ThemeData(
        primaryColor: AppColors.darkBlueColor,
        textTheme: AppThemes.textTheme1,
      ),
      home: const LoadingView(),
      darkTheme: ThemeData.dark(),
      routes: 
        {
          loginRoute: (context) => LoginView(),
          registerRoute: (context) => RegisterView(),
          homeRoute: (context) => const HomeView(),
          dashboardRoute: (context) => const DashboardView(),
          createPostRoute: (context) => const CreatePostView(),
        }
    );
  }
}


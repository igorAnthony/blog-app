

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/constant/text_theme.dart';
import 'package:flutter_blog_app/features/auth/presentation/login_view.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/features/profile/presentation/edit_profile_view.dart';
import 'package:flutter_blog_app/utils/loading_view.dart';
import 'package:flutter_blog_app/features/posts/presentation/create_post_view.dart';
import 'package:flutter_blog_app/main_layout.dart';
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
          mainLayoutRoute: (context) => const MainLayout(),
          createPostRoute: (context) => const CreatePostView(),
          editProfileRoute: (context) => const EditProfileView(),
        }
    );
  }
}


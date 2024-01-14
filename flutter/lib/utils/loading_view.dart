import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/main_layout.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingView extends ConsumerStatefulWidget {
  const LoadingView({super.key});

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends ConsumerState<LoadingView> {

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStoreProvider.notifier);
    
    return FutureBuilder(
      future: Future.value(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
            return const MainLayout();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderContent extends ConsumerWidget {
  const HeaderContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Hi, ${ref.read(userStoreProvider).value?.name ?? 'Name'}!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          IconButton(
            onPressed: () {
              ref.read(userStoreProvider.notifier).logout();
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

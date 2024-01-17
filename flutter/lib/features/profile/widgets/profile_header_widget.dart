import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeaderWidget extends ConsumerStatefulWidget {
  @override
  _ProfileHeaderWidgetState createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends ConsumerState<ProfileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile", style: Theme.of(context).textTheme.titleMedium!),
            //menu with edit profile and logout
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit Profile'),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
              onSelected: (value) {
                if(value == 'edit'){
                  Navigator.pushNamed(context, editProfileRoute);
                }
                else if(value == 'logout'){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            ref.read(userStoreProvider.notifier).logout();
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    )
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }
}

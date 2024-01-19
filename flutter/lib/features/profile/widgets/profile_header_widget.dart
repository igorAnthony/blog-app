import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            //logout with show confirm dialog
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 10),
                        Text('Logout'),
                      ],
                    ),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel', style: TextStyle(color: Colors.red)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ref.read(userStoreProvider.notifier).logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                        },
                        child: Text('Logout', style: TextStyle(color: AppColors.darkBlueColor)),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            )       

          ],
        ),
      ],
    );
  }
}

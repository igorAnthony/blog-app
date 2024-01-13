import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/services/user_service.dart';

class HeaderContent extends StatelessWidget {
  const HeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Hi, Igor!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          IconButton(
            onPressed: () {
              logout().then((value) =>
                  navigatorPushNamedAndRemoveUntil(context, loginRoute));
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

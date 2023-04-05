import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/services/user_service.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      navigatorPushNamedAndRemoveUntil(context, loginRoute);
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        navigatorPushNamedAndRemoveUntil(context, homeRoute);
      } else if (response.error == unauthorized) {
        navigatorPushNamedAndRemoveUntil(context, loginRoute);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
  }
  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      )),
    );
  }
}

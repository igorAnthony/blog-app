import 'package:flutter/material.dart';

const loginRoute = '/login';
const registerRoute = '/register';
const homeRoute  ='/home';
const createPostRoute = '/posts/create';
const editPostRoute = '/posts/create';
const commentsRoute = '/comments';
const dashboardRoute = '/dashboard';
const story = '/story';



void navigatorPushNamedAndRemoveUntil(BuildContext context, String rota){
  Navigator.of(context).pushNamedAndRemoveUntil(
      rota,
      (Route<dynamic> route) => false,
  );
}

void navigatorPushNamed(BuildContext context, String rota){
  Navigator.of(context).pushNamed(
      rota
  );
}

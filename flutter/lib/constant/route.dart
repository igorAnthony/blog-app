import 'package:flutter/material.dart';

const loginRoute = '/login';
const registerRoute = '/register';
const homeRoute  ='/home';
const postRoute = '/posts';
const createPostRoute = '/posts/create';
const editPostRoute = '/posts/create';
const commentsRoute = '/comments';



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

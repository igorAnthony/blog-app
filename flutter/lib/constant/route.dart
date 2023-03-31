import 'package:flutter/material.dart';

const loginRoute = '/login';
const registerRoute = '/register';
const homeRoute  ='/home';
const postRoute = '/posts';
const createPostRoute = '/posts/create';

void navigatorRoute(BuildContext context, String rota){
  Navigator.of(context).pushNamedAndRemoveUntil(
      rota,
      (Route<dynamic> route) => false,
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/dimensions.dart';

class AppThemes {
  static const textTheme1 = TextTheme(
    //font family = google font: exo2
     
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.w200,
    ),
    titleSmall: TextStyle(
      color: AppColors.darkBlueColor,
      fontSize: 16,
      fontWeight: FontWeight.bold
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: Dimensions.pageTitleFontSize,
      fontWeight: FontWeight.bold,
    ), 
  );
}
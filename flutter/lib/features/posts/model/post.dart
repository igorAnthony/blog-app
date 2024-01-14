import 'dart:convert';

import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_quill/flutter_quill.dart';

class Post {
  int? id;
  List<dynamic>? body;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? title;
  int? categoryId;
  int? likesCount;
  int? commentsCount;
  User? user;

  Post(
    {
      this.id, 
      this.likesCount, 
      this.body,
      this.commentsCount,  
      this.user, 
      this.image,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.title,
    }
  );
  factory Post.fromJson(Map<String, dynamic> json) {
    Post post = Post();
    post.id = json['id'];
    post.body = json['body'] != null ? jsonDecode(json['body']) : null;
    post.image = json['image'];
    post.createdAt = json['createdAt'];
    post.updatedAt = json['updatedAt'];
    post.title = json['title'];
    post.categoryId = json['categoryId'];
    post.likesCount = json['likesCount'];
    post.commentsCount = json['commentsCount'];
    post.user = json['user'] != null ? User.fromJson(json['user']) : null;
    return post;
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'title': title,
      'categoryId': categoryId,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'user': user?.toJson(), // assuming User has a proper toJson method
    };
  }
}
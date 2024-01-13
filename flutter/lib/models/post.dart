import 'package:flutter_blog_app/models/user.dart';

class Post {
  int? id;
  String? body;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? subtitle;
  int? likesCount;
  int? commentsCount;
  User? user;
  bool? selfLiked;

  Post(
    {
      this.id, 
      this.body, 
      this.likesCount, 
      this.commentsCount,  
      this.user, 
      this.selfLiked,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.subtitle     
    }
  );
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      body: json['body'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      title: json['title'],
      subtitle: json['subtitle'],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      selfLiked: json['likes'].length > 0,
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image']
      )
    );
  }
  factory Post.toJson(Post post){
    return Post(
      id: post.id,
      body: post.body,
      image: post.image,
      createdAt: post.createdAt,
      updatedAt: post.updatedAt,
      title: post.title,
      subtitle: post.subtitle,
      likesCount: post.likesCount,
      commentsCount: post.commentsCount,
      selfLiked: post.selfLiked,
      user: User(
        id: post.user!.id,
        name: post.user!.name,
        image: post.user!.image
      )
    );
  }
}
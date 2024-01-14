import 'package:flutter_blog_app/features/auth/model/user.dart';

class Post {
  int? id;
  String? body;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? title;
  int? specialityId;
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
      this.specialityId,
      this.createdAt,
      this.updatedAt,
      this.title,
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
      specialityId: json['speciality_id'],
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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'title': title,
      'specialityId': specialityId,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'selfLiked': selfLiked,
      'user': user?.toJson(), // assuming User has a proper toJson method
    };
  }
}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';

class PostsRepository {
  String? _token = '';
  TokenStorage _tokenStorage = TokenStorage();

  PostsRepository() {
    _tokenStorage.getToken().then((value) => _token = value);
  }

  Future<List<Post>> getPosts({int? categoryId, int? userId}) async {
    List<Post> posts = [];
    try {
      String url = postsURL;
      if(categoryId != null){
        url += "?category_id=$categoryId";
      }else if(userId != null) {
        url += "?user_id=$userId";
      }

      _token = await _tokenStorage.getToken();
      final response = await Dio().get(url, options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          if(response.data == null) {
            posts = [];
            break;
          }
          response.data['posts'].forEach((p){
            posts.add(Post.fromJson(p));
          });          
          break;
        case 401:
          print('Unauthorized');
          break;
        default:
          print('Error');
          break;
      }
    } catch (e) {
      print('Erro na requisição getPosts: $e');
    }
    return posts;
  }

  //get one post
  Future<Post> getOnePost(int postId) async {
    Post post = Post();
    try{
      _token = await _tokenStorage.getToken();
      final response = await Dio().get('$postsURL/$postId', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));

      switch(response.statusCode) {
        case 200: 
          if(response.data == null) {
            post = Post();
            break;
          }
          post = Post.fromJson(response.data['post']);
          break;
        case 401:
          print('Unauthorized');
          break;
        default:
          print('Error');
          break;
      }
    } catch(e) {
      rethrow;
    }
    return post;
  }

  //get post by user_id
  Future<List<Post>> getPostByUserId(int userId) async {
    List<Post> posts = [];
    try{
      _token = await _tokenStorage.getToken();
      final response = await Dio().get('$postsURL?user_id=$userId', 
          options: Options(
            headers: {
            'Accept' : 'application/json',
            'Authorization' : 'Bearer $_token'
          }
        )
      );

      switch(response.statusCode) {
        case 200: 
          if(response.data == null) {
            posts = [];
            break;
          }
          posts = (response.data['posts'] as List).map((p) => Post.fromJson(p)).toList();
          break;
        case 401:
          print('Unauthorized');
          break;
        default:
          print('Error');
          break;
      }
    } catch(e) {
      rethrow;
    }
    return posts;
  }

  Future<String> createPost(Post post) async {
    try {
      _token = await _tokenStorage.getToken();
      final response = await Dio().post(postsURL, data: {
        'post' : post.toJson()
      }, options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          return '200';
        case 401:
          return '401';
        default:
          return '${response.statusCode}';
      }
    } catch (e) {
      return 'Erro na requisição createPost: $e';
    }
  }
  //edit post
  Future<ApiResponse> editPost(Post post) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await Dio().put('$postsURL/${post.id}', data: {
        'body' : post.toJson()
      }, options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          apiResponse.data = Post.fromJson(response.data);
          break;
        case 401:
          apiResponse.error = 'Unauthorized';
          break;
        default:
          apiResponse.error = 'Error';
          break;
      }
    } catch (e) {
      rethrow;
    }
    return apiResponse;
  }
  //delete post
  Future<ApiResponse> deletePost(int postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await Dio().delete('$postsURL/$postId', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.data);
          break;
        case 401:
          apiResponse.error = 'Unauthorized';
          break;
        default:
          apiResponse.error = 'Error';
          break;
      }
    } catch (e) {
      rethrow;
    }
    return apiResponse;
  }
  //like or dislike post
  Future<ApiResponse> likeDislikePost(int postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await Dio().post('$postsURL/$postId/like', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.data);
          break;
        case 401:
          apiResponse.error = 'Unauthorized';
          break;
        default:
          apiResponse.error = 'Error';
          break;
      }
    } catch (e) {
      rethrow;
    }
    return apiResponse;
  }
  
}
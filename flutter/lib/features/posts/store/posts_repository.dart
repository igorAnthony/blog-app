import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/features/utils/token_storage.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/post.dart';

class PostsRepository {
  String? _token = '';
  TokenStorage _tokenStorage = TokenStorage();

  PostsRepository() {
    _tokenStorage.getToken().then((value) => _token = value);
  }

  Future<ApiResponse> getPosts() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await Dio().get(baseURL + postsURL, options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.data)['posts'].map((p) => Post.fromJson(p)).toList();
          apiResponse.data as List<dynamic>;
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

  Future<ApiResponse> createPost(String body, String? image) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await Dio().post(baseURL + postsURL, data: image != null? {
        'body' : body,
        'image' : image
      } : {
        'body' : body
      }, options: Options(
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
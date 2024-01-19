import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/features/story/model/story_model.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_blog_app/utils/api_response.dart';

class StoriesRepository {
  String? _token = '';
  TokenStorage _tokenStorage = TokenStorage();

  //get post by user_id
  Future<List<Story>> getStoryByUserId(int userId) async {
    List<Story> posts = [];
    try{
      _token = await _tokenStorage.getToken();
      final response = await Dio().get('$storiesURL?user_id=$userId', 
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
          posts = (response.data['posts'] as List).map((p) => Story.fromJson(p)).toList();
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

  Future<String> createStory(Story story) async {
    try {
      _token = await _tokenStorage.getToken();
      final response = await Dio().post(storiesURL, data: {
        'story' : story.toJson()
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
      return 'Erro na requisição createStory: $e';
    }
  }
  //delete post
  Future<ApiResponse> deleteStory(int postId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await Dio().delete('$storiesURL/$postId', options: Options(
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
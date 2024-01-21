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
  Future<List<List<Story>>> getStoryByUserId(int userId) async {
    List<List<Story>> stories = [];
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
            stories = [];
            break;
          }
          /* exemplo do retorno abaixo
            {
              "stories": [
                [
                  {
                    "id": 1,
                    "user_id": 101,
                    "image": "https://example.com/image1.jpg",
                    "timestamp": "2024-01-19T12:30:45Z"
                  },
                  {
                    "id": 2,
                    "user_id": 102,
                    "image": "https://example.com/image2.jpg",
                    "timestamp": "2024-01-19T13:15:20Z"
                  }
                ],
                [
                  {
                    "id": 3,
                    "user_id": 103,
                    "image": "https://example.com/image3.jpg",
                    "timestamp": "2024-01-19T14:45:10Z"
                  },
                  {
                    "id": 4,
                    "user_id": 104,
                    "image": "https://example.com/image4.jpg",
                    "timestamp": "2024-01-19T15:20:30Z"
                  }
                ]
              ]
            }

          */
          // stories = (response.data['stories'] as List).map((p) => Story.fromJson(p)).toList();
          response.data['stories'].forEach(
            (p){
              stories.add((p as List).map((s) => Story.fromJson(s)).toList());
            }
          ).toList();
          
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
    return stories;
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
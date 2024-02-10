import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_blog_app/features/story/model/list_story_model.dart';
import 'package:flutter_blog_app/features/story/model/story_model.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_blog_app/utils/api_response.dart';

class StoriesRepository {
  String? _token = '';
  TokenStorage _tokenStorage = TokenStorage();

  //get post by user_id
  Future<List<ListStory>> getStoryByUserId(User user) async {
    List<ListStory> stories = [];
    try{
      _token = await _tokenStorage.getToken();
      final response = await Dio().get('$storiesURL?user_id=${user.id}', 
          options: Options(
            headers: {
            'Accept' : 'application/json',
            'Authorization' : 'Bearer $_token'
          }
        )
      );
      print(response.data);
      switch(response.statusCode) {
        case 200: 
          final data = response.data['stories'];
          if (data != null) {
            final currentUserStories = data['current_user_stories'];
            if (currentUserStories != null) {
              // Processar histórias do usuário atual
              ListStory currentUserlistStory = ListStory();
              currentUserlistStory.userId = user.id;
              currentUserlistStory.avatar = user.avatar;
              currentUserlistStory.createdAt = user.createdAt;
              
              List<Story> userStories = currentUserStories.map<Story>((p) => Story.fromJson(p)).toList();
              currentUserlistStory.setStories(userStories);

              stories.add(currentUserlistStory);
            }
          
            // Process friends stories
            final friendsStories = data['friends'];
            if (friendsStories != null) {
              friendsStories.forEach((s) {
                ListStory listStory = ListStory.fromJson(s);
                if(listStory.stories?.isNotEmpty ?? false) stories.add(listStory);
              });
            }
          }
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
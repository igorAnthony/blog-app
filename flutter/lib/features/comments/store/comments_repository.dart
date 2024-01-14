import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/features/comments/comment_model.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_blog_app/utils/api_response.dart';

class CommentsRepository{
  String? _token = '';
  final TokenStorage _tokenStorage = TokenStorage();

  CommentsRepository(){
    _tokenStorage.getToken().then((value) => _token = value);
  }

  Future<ApiResponse> getComments(int postId) async{
    ApiResponse apiResponse = ApiResponse();

    try{
      final response = await Dio().get('$baseURL$postsURL/$postId/comments', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode){
        case 200:
          apiResponse.data = jsonDecode(response.data)['comments'].map((c) => Comment.fromJson(c)).toList();
          apiResponse.data as List<dynamic>;
          break;
        case 401:
          apiResponse.error = 'Unauthorized';
          break;
        default:
          apiResponse.error = 'Error';
          break;
      }
    } catch (e){
      rethrow;
    }
    return apiResponse;
  }
  //create comment
  Future<ApiResponse> createComment(int postId, String? comment) async{
    ApiResponse apiResponse = ApiResponse();

    try{
      final response = await Dio().post('$baseURL$postsURL/$postId/comments', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ), data: {
        'comment' : comment
      });
      switch(response.statusCode){
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
    } catch (e){
      rethrow;
    }
    return apiResponse;
  }
  //edit comment
  Future<ApiResponse> editComment(Comment newComment, String comment) async{
    ApiResponse apiResponse = ApiResponse();
    newComment.comment = comment;

    try{
      final response = await Dio().put('$baseURL$postsURL/${newComment.user!.id}/comments/${newComment.id}', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ), data: {
        'comment' : comment
      });
      switch(response.statusCode){
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
    } catch (e){
      rethrow;
    }
    return apiResponse;
  }
  //delete comment
  Future<ApiResponse> deleteComment(int commentId) async{
    ApiResponse apiResponse = ApiResponse();

    try{
      final response = await Dio().delete('$baseURL$commentsURL/$commentId', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode){
        case 200:
          apiResponse.data = jsonDecode(response.data)['message'];
          break;
        case 401:
          apiResponse.error = 'Unauthorized';
          break;
        default:
          apiResponse.error = 'Error';
          break;
      }
    } catch (e){
      rethrow;
    }
    return apiResponse;
  }
}
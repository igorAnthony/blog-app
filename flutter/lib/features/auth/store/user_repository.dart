import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  TokenStorage _tokenStorage = TokenStorage();
  String? _token;

  UserRepository() {
    _tokenStorage.getToken().then((value) => _token = value);
  }

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await Dio().post(loginURL, data: {
        'email' : email,
        'password' : password
      });
      _token = await _tokenStorage.getToken();
      switch(response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(response.data);
          await _tokenStorage.saveToken(response.data['token']);
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setInt('userId', response.data['user']['id']);
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

  Future<ApiResponse> register(String name, String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await Dio().post(registerURL, data: {
        'name' : name,
        'email' : email,
        'password' : password
      });
      _token = await _tokenStorage.getToken();
      switch(response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.data));
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

  Future<ApiResponse> deleteUser(String id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      _token = await _tokenStorage.getToken();
      final response = await Dio().delete('$userURL/$id', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
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

  Future<User> getUser() async {
    int userId = await getUserId();
    print("userId: $userId");
    User user = User();
    try {
      _token = await _tokenStorage.getToken();
      final response = await Dio().get('$userURL/$userId', options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          if (response.data != null && response.data['user'] != null) {
            print("response.data['user']: ${response.data['user']}");
            user = User.fromJson(response.data['user']);
          } else {
            print('User data is null or missing');
          }
          break;
        case 401:
          print('Unauthorized');
          break;
        default:
          print('Error');
          break;
      }
    } catch(e){
      print('Error: $e');
    }  
    return user;
  }
  
  Future<ApiResponse> updateUser(User updatedUser) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await Dio().put(userURL, data: updatedUser.toJson(), options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.data));
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

  Future<int> getUserId() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 0;
  }

  Future<bool> logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('token');
  }

  String? getStringImage(File? file){
    if(file==null) return null;
    return base64Encode(file.readAsBytesSync());
  }
}
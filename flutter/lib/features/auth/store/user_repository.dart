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

  Future<User> login(String email, String password) async {
    User user = User();
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(loginURL, data: {
        'email' : email,
        'password' : password
      });
      _token = await _tokenStorage.getToken();
      switch(response.statusCode) {
        case 200:
          user = User.fromJson(response.data['user']);
          await _tokenStorage.saveToken(response.data['token']);
          await pref.setString('user', jsonEncode(response.data['user']));
          break;
        case 401:
          print('Unauthorized');
          break;
        default:
          print('Error');
          break;
      }
    } catch (e) {
      print('Erro na requisição: $e');
    }
    return user;

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
    User user = User();
    String? token = await _tokenStorage.getToken();
    try {
      final response = await Dio().get(userURL,   
      options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          if (response.data != null && response.data['user'] != null) {
            user = User.fromJson(response.data['user']);
            print(user.toJson());
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
      print("entrei");
      print('Error: $e');
    }  
    return user;
  }
  
  Future<String> updateUser(User updatedUser) async {
    String message = '';
    try {
      final response = await Dio().put(userURL, data: updatedUser.toJson(), options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          message = 'User updated successfully';
          break;
        case 401:
          message = 'Unauthorized';
          break;
        default:
          message = 'Error';
          break;
      }
    } catch (e) {
      rethrow;
    }  
    return message;
  }

  Future<bool> logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('user');
    await pref.remove('categories');
    await _tokenStorage.deleteToken();
    return true;
  }

  
}
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/user.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  String _token = '';

  UserRepository() {
    getToken().then((value) => _token = value);
  }

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await Dio().post(baseURL + loginURL, data: {
        'email' : email,
        'password' : password
      });
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

  Future<ApiResponse> register(String name, String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await Dio().post(baseURL + registerURL, data: {
        'name' : name,
        'email' : email,
        'password' : password
      });
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
      final response = await Dio().delete('$baseURL$userURL/$id', options: Options(
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

  Future<ApiResponse> getUser() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await Dio().get(baseURL + userURL, options: Options(
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
  
  Future<ApiResponse> updateUser(User updatedUser) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await Dio().put(baseURL + userURL, data: User.toJson(updatedUser), options: Options(
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

  Future<String> getToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
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
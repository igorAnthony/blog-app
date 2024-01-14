import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/features/categories/category_model.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepository{
  String? _token;
  TokenStorage _tokenStorage = TokenStorage();

  CategoryRepository() {
    _tokenStorage.getToken().then((value) => _token = value);
  }

  //get categories
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = await _tokenStorage.getToken();
      final response = await Dio().get(categoriesURL, options: Options(
        headers: {
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $_token'
        }
      ));
      switch(response.statusCode) {
        case 200:
          if(response.data == null) {
            break;
          }
          categories = (response.data['categories'] as List).map((c) => Category.fromJson(c)).toList();
          List<String> categoriesString = categories.map((e) => jsonEncode(e.toJson())).toList();
          prefs.setStringList('categories', categoriesString);                    
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
    return categories;
  }
}
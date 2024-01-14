import 'dart:convert';

import 'package:flutter_blog_app/features/categories/category_model.dart';
import 'package:flutter_blog_app/features/categories/category_repository.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'category_store.g.dart';

@Riverpod(keepAlive: true)
class CategoriesStore extends _$CategoriesStore{
  late CategoryRepository _categoryRepository;

  @override
  Future<List<Category>> build() async {
    _categoryRepository = CategoryRepository();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Category>? categories = [];
    if(prefs.containsKey('categories')){
      List<String> categoriesString = prefs.getStringList('categories') ?? [];
      for (var element in categoriesString) { 
        categories.add(Category.fromJson(jsonDecode(element)));
      }
    }else{
      categories = await _categoryRepository.getCategories();
    }
    return categories;
  }

}
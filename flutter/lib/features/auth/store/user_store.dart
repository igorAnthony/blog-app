import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/auth/store/user_repository.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_store.g.dart';

enum Status { initial, loading, loaded, error }

@Riverpod(keepAlive: true)
class UserStore extends _$UserStore{
  late UserRepository _userRepository;
  bool loading = false;
  bool isLogged = false;

  @override
  Future<User> build() async {
    loading = true;
    _userRepository = UserRepository();
    String? token = await TokenStorage().getToken();
    User user = token != null ? await _userRepository.getUser(state.value!.id) : User();
    isLogged = user.id != null;
    loading = false;
    return user;
  }

  Future<bool> login(String email, String password) async {
    User user  = await _userRepository.login(email, password);
    state = AsyncValue.data(user);
    return user.id != null;
  }

  Future<ApiResponse> register(String name, String email, String password) async {
    ApiResponse apiResponse = await _userRepository.register(name, email, password).then((value) => value);
    return apiResponse;
  }

  Future<void> logout() async {
    await _userRepository.logout();
    state = AsyncValue.data(User());
  }

  Future<void> updateProfile(User user) async {
    String message = await _userRepository.updateUser(user);
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
}
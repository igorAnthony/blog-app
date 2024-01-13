import 'package:flutter_blog_app/features/auth/store/user_repository.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_store.g.dart';

enum Status { initial, loading, loaded, error }

@Riverpod(keepAlive: true)
class UserStore extends _$UserStore{
  late UserRepository _userRepository;

  @override
  Future<User> build() async {
    _userRepository = UserRepository();
    ApiResponse apiResponse = await _userRepository.getUser().then((value) => value);
    User user = apiResponse.data as User;
    return user;
  }

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = await _userRepository.login(email, password).then((value) => value);
    return apiResponse;
  }

  Future<ApiResponse> register(String name, String email, String password) async {
    ApiResponse apiResponse = await _userRepository.register(name, email, password).then((value) => value);
    return apiResponse;
  }

  Future<void> logout() async {
    await _userRepository.logout();
    state = AsyncValue.data(User());
  }

  Future<ApiResponse> updateProfile(User user) async {
    ApiResponse apiResponse = await _userRepository.updateUser(user).then((value) => value);
    return apiResponse;
  }

}
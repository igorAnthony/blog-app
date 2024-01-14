import 'package:flutter_blog_app/features/auth/store/user_repository.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_store.g.dart';

enum Status { initial, loading, loaded, error }

@Riverpod(keepAlive: true)
class UserStore extends _$UserStore{
  late UserRepository _userRepository;
  bool _loading = false;
  bool get loading => _loading;

  bool get isLogged => state.value?.id != null;


  @override
  Future<User> build() async {
    _loading = true;
    _userRepository = UserRepository();
    String? token = await TokenStorage().getToken();
    User user = token != null ? await _userRepository.getUser().then((value) => value) : User();
    _loading = false;
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

  Future<ApiResponse> updateProfile(User user) async {
    ApiResponse apiResponse = await _userRepository.updateUser(user).then((value) => value);
    return apiResponse;
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/auth/presentation/login_view.dart';
import 'package:flutter_blog_app/main_layout.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingView extends ConsumerStatefulWidget {
  const LoadingView({super.key});

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends ConsumerState<LoadingView> {

  @override
  Widget build(BuildContext context) {
    final isLogged = ref.watch(userStoreProvider);
    
    //return isLogged ? const MainLayout() : LoginView();
    //retorna o login apenas se eu tiver id do meu usuario, se não gostaria de ficasse em loading, se retorna falso ele vai para o login
    return isLogged.when(
      data: (data){
        print('erro1');
        if(data.id != null){

          return const MainLayout();
        }else{
          print('teste2');
          return LoginView();
        }
      }, 
      error: (error, stack){ 
        print('deu erro');
        return LoginView();
      }, 
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(),),)
    );
  }
}

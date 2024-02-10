import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/utils/token_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password  = TextEditingController();
  final bool loading = false;


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('Blog App', style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              )),
              const Spacer(),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                controller: _email,
                validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
                decoration: kInputDecoration('Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _password,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Invalid password address' : null,
                decoration: kInputDecoration('Password'),
              ),
              const SizedBox(height: 30),
              loading ? const Center(child: CircularProgressIndicator(strokeWidth: 3,),) :
              kTextButton('Login', (){
                if(formkey.currentState!.validate()){
                  bool loginSuccessful = false;
                  ref.read(userStoreProvider.notifier).login(_email.text, _password.text).then((value) => loginSuccessful = value);
                  if(loginSuccessful){
                    navigatorPushNamedAndRemoveUntil(context, mainLayoutRoute);
                  }
                }
              }),
              const Spacer(),
              kLoginOrRegisterHint("Not registered yet? ", 'Register here', (){
                navigatorPushNamedAndRemoveUntil(context, registerRoute);
              }),
              const Spacer(),
            ],
          ),
        )
      )
    );
  }
}
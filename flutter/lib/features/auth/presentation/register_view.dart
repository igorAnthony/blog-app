import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RegisterView extends ConsumerWidget {
  RegisterView({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();
  final bool loading = false;
  
  void _registerUser(ApiResponse response) async {    
    if(response.error == null){
      //navigatorPushNamedAndRemoveUntil(context, loginRoute);
    }
  }

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
              const Text('Register', style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              )),
              const Spacer(),
              TextFormField(
                keyboardType: TextInputType.name,
                enableSuggestions: false,
                autocorrect: false,
                controller: _name,
                validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                decoration: kInputDecoration('Name'),
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordConfirm,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                validator: (val) => val != _password.text ? 'Confirm password does not match' : null,
                decoration: kInputDecoration('Confirm password'),
              ),
              const SizedBox(height: 30,),
              loading ? const Center(child: CircularProgressIndicator(strokeWidth: 3,),) :
              kTextButton('Register', (){
                if(formkey.currentState!.validate()){
                  ref.read(userStoreProvider.notifier).register(_name.text, _email.text, _password.text).then((value) => _registerUser(value));
                }
              }),
              const Spacer(),
              kLoginOrRegisterHint("Already have an account? ", 'Login here', (){
                navigatorPushNamedAndRemoveUntil(context, loginRoute);
              }),
              const Spacer(),
            ],
          ),
        )
      )
    );
  }
}
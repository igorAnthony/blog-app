import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/dimensions.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/user.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool loading = false;
  void _loginUser() async {
    ApiResponse response = await login(_email.text, _password.text);

    if(response.error == null){
      _saveAndRedirectToHome(response.data as User);
    }else{
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text("${response.error}") 
      ));
    }
  }
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? "0");
    await pref.setInt('userId', user.id ?? 0);
    navigatorPushNamedAndRemoveUntil(context, homeRoute);
  }
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text('Blog App', style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              )),
              Spacer(),
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
                  setState(() {
                    loading = true;
                    _loginUser();
                  });
                }
              }),
              Spacer(),
              kLoginOrRegisterHint("Not registered yet? ", 'Register here', (){
                navigatorPushNamedAndRemoveUntil(context, registerRoute);
              }),
              Spacer(),
            ],
          ),
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/user.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _passwordConfirm;
  bool loading = false;
  void _registerUser() async {
    ApiResponse response = await register(_name.text, _email.text, _password.text);
    
    if(response.error == null){
      navigatorPushNamedAndRemoveUntil(context, loginRoute);
    }else{
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text("${response.error}") 
      ));
    }
  }
  
  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _passwordConfirm = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _passwordConfirm.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
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
            const SizedBox(height: 10,),
            loading ? const Center(child: CircularProgressIndicator(strokeWidth: 3,),) :
            kTextButton('Register', (){
              if(formkey.currentState!.validate()){
                setState(() {
                  loading = true;
                  _registerUser();
                });
              }
            }),
            const SizedBox(height: 10,),
            kLoginOrRegisterHint("Already have an account? ", 'Login here', (){
              navigatorPushNamedAndRemoveUntil(context, loginRoute);
            }),
          ],
        )
      )
    );
  }
}
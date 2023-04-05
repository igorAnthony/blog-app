import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/user.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? user;
  bool _loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  late TextEditingController _name;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  Future _getImage() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);      
      });
    }
  }

  void getUser() async{
    ApiResponse response = await getUserDetail();
    
    if(response.error == null){
      setState(() {
        user = response.data as User;
        _loading = false;
        _name.text = user!.name ?? '';
      });
      print('${user!.image}');
    }
    else if(response.error == unauthorized){
      logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  void updateProfile() async{
    ApiResponse response = await updateUser(_name.text, getStringImage(_imageFile));
    setState(() {
        _loading = false;
      });
    if(response.error == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data}')
      ));
    }
    else if(response.error == unauthorized){
      logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  @override
  void initState() {
    _name = TextEditingController();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading? Center(child: CircularProgressIndicator(),)
    : Padding(
      padding: const EdgeInsets.only(top:40, left:40, right: 40),
      child: ListView(
        children: [
          Center(
            child: GestureDetector(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: _imageFile == null ? user!.image != null ? DecorationImage(
                    image: NetworkImage('${user!.image}'),
                    fit: BoxFit.cover
                  ) : null : DecorationImage(
                    image: FileImage(_imageFile ?? File('')),
                    fit: BoxFit.cover
                  ),
                  color: Colors.purpleAccent
                ),
              ),
              onTap: () {
                _getImage();
              },
            ),
          ),
          const SizedBox(height: 20,),
          Form(
            key: formKey,
            child: TextFormField(
              decoration: kInputDecoration('Name'),
              controller: _name,
              validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
            ),
          ),
          const SizedBox(height: 20,),
          kTextButton('Update', (){
            if(formKey.currentState!.validate()){
              setState(() {
                _loading = true;
              });
              updateProfile();
            }
          })
        ],
      ),
    );
  }
}
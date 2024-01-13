import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/constant/colors.dart';
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
  late TextEditingController _aboutMe;
  late TextEditingController _speciality;
  late TextEditingController _username;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;
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
        _aboutMe.text = user!.aboutMe ?? '';
        _speciality.text = user!.speciality ?? '';
        _username.text = user!.username ?? '';
        _password.text = user!.password ?? '';
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
    User user = User(
      name: _name.text,
      aboutMe: _aboutMe.text,
      speciality: _speciality.text,
      username: _username.text,
      password: _password.text,
      image: getStringImage(_imageFile)
    );
    ApiResponse response = await updateUser(user);
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
    _aboutMe = TextEditingController();
    _speciality = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading? Center(child: CircularProgressIndicator(),)
    : Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profile", style: Theme.of(context).textTheme.titleMedium!),
              //menu with edit profile and logout
              PopupMenuButton(
                icon: Icon(Icons.more_horiz),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Edit Profile'),
                    value: 'edit',
                  ),
                  PopupMenuItem(
                    child: Text('Logout'),
                    value: 'logout',
                  ),
                ],
                onSelected: (value) {
                  if(value == 'edit'){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Edit Profile'),
                        content: Container(
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
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
                              const SizedBox(height: 20,),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: kInputDecoration('Name'),
                                      controller: _name,
                                      validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      decoration: kInputDecoration('About Me'),
                                      controller: _aboutMe,
                                      validator: (val) => val!.isEmpty ? 'Invalid About Me' : null,
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      decoration: kInputDecoration('Speciality'),
                                      controller: _speciality,
                                      validator: (val) => val!.isEmpty ? 'Invalid Speciality' : null,
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      decoration: kInputDecoration('Username'),
                                      controller: _username,
                                      validator: (val) => val!.isEmpty ? 'Invalid Username' : null,
                                    ),
                                    const SizedBox(height: 10,),
                                    TextFormField(
                                      decoration: kInputDecoration('Password'),
                                      controller: _password,
                                      validator: (val) => val!.isEmpty ? 'Invalid Password' : null,
                                    ),
                                    const SizedBox(height: 10,),
                                     TextFormField(
                                      decoration: kInputDecoration('Confirm Password'),
                                      controller: _confirmPassword,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Invalid Confirm Password';
                                        }
                                        if (val != _password.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Container(
                            child: kTextButton('Update', (){
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  _loading = true;
                                });
                                updateProfile();
                              }
                            }),
                          )
                        ],
                      )
                    );
                  }
                  else if(value == 'logout'){
                    logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
                  }
                },
              )
            ],
          ),
          const SizedBox(height: 30,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 0.4,
                  offset: Offset(0, 0)
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.darkBlueColor, width: 3)
                          ),
                          child: Container(
                            width: 50,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
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
                        ),
                        onTap: () {
                          _getImage();
                        },
                      ),
                      SizedBox(width: 20,),
                  
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('@igoranthony', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black.withOpacity(0.4), fontSize: 12),),
                          Text('${user!.name}', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 24),),
                          SizedBox(height: 5,),
                          Text('Flutter Developer', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),)
                        ],
                      ),
                  
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('About me', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black),),
                  SizedBox(height: 10,),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, diam id aliquam ultrices, nisl nunc aliquet enim, vitae aliquam nisl nunc eu nisl. Sed euismod, diam id aliquam ultrices, nisl nunc aliquet enim, vitae aliquam nisl nunc eu nisl.', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black.withOpacity(0.3), fontSize: 14),),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 230,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.darkBlueColor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(0.15)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('1.5k', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 18),),
                                Text('Posts', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('2.5k', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 18),),
                                Text('Following', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('1.5k', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 18),),
                                Text('Followers', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ],
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
           SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('My Posts', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 18),),
                      kTextButton('More', (){}, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 14),)
                    ],
                  ),
          // const SizedBox(height: 20,),
          // Form(
          //   key: formKey,
          //   child: TextFormField(
          //     decoration: kInputDecoration('Name'),
          //     controller: _name,
          //     validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
          //   ),
          // ),
          // const SizedBox(height: 20,),
          // kTextButton('Update', (){
          //   if(formKey.currentState!.validate()){
          //     setState(() {
          //       _loading = true;
          //     });
          //     updateProfile();
          //   }
          // })
        ],
      ),
    );
  }
}
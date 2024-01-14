import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/colors.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/store/user_repository.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
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

  void updateProfile() async{
    User user = User(
      name: _name.text,
      aboutMe: _aboutMe.text,
      speciality: _speciality.text,
      username: _username.text,
      password: _password.text,
      image: UserRepository().getStringImage(_imageFile)
    );
    ApiResponse apiResponse = await ref.read(userStoreProvider.notifier).updateProfile(user);
    if(apiResponse.error == null){
      Navigator.pop(context);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStoreProvider);
    return user.asData?.isLoading ?? true ? const Center(child: CircularProgressIndicator(),)
    : Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profile", style: Theme.of(context).textTheme.titleMedium!),
              //menu with edit profile and logout
              PopupMenuButton(
                icon: const Icon(Icons.more_horiz),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit Profile'),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ],
                onSelected: (value) {
                  if(value == 'edit'){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Edit Profile'),
                        content: Container(
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: _imageFile == null ? user.value!.image != null ? DecorationImage(
                                      image: NetworkImage('${user.value!.image}'),
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
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              ref.read(userStoreProvider.notifier).logout();
                              Navigator.pop(context);
                              Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      )
                    );
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
                  offset: const Offset(0, 0)
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.darkBlueColor, width: 3)
                          ),
                          child: Container(
                            width: 50,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: _imageFile == null ? user.value!.image != null ? DecorationImage(
                                image: NetworkImage('${user.value!.image}'),
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
                      const SizedBox(width: 20,),
                  
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${user.value?.username != null ?  user.value!.username : 'Username'}', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black.withOpacity(0.4), fontSize: 12),),
                          Text('${user.value!.name}', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 24),),
                          const SizedBox(height: 5,),
                          Text('${user.value?.speciality != null ? user.value!.speciality : 'Speciality'}', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),)
                        ],
                      ),
                  
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Text('About me', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black),),
                  const SizedBox(height: 10,),
                  Text('${user.value?.aboutMe != null ? user.value!.aboutMe : ''}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black.withOpacity(0.3), fontSize: 14),),
                  const SizedBox(height: 10,),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.only(right: 10),
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
                            padding: const EdgeInsets.only(right: 15),
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
                            padding: const EdgeInsets.only(right: 20),
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
           const SizedBox(height: 20,),
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
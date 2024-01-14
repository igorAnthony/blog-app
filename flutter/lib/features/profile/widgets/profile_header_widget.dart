import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeaderWidget extends ConsumerStatefulWidget {
  @override
  _ProfileHeaderWidgetState createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends ConsumerState<ProfileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStoreProvider);
    File? _imageFile;
    late TextEditingController _name;
    late TextEditingController _aboutMe;
    late TextEditingController _speciality;
    late TextEditingController _username;
    late TextEditingController _password;
    late TextEditingController _confirmPassword;

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    @override
    void initState() {
      super.initState();
      _name = TextEditingController(text: user.value!.name);
      _aboutMe = TextEditingController(text: user.value!.aboutMe);
      _speciality = TextEditingController(text: user.value!.speciality);
      _username = TextEditingController(text: user.value!.username);
      _password = TextEditingController(text: user.value!.password);
      _confirmPassword = TextEditingController(text: user.value!.password);
    }

    
    return Column(
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
                                  image: user.value!.image != null ? DecorationImage(
                                    image: NetworkImage('${user.value!.image}'),
                                    fit: BoxFit.cover
                                  ) : DecorationImage(
                                    image: FileImage(_imageFile ?? File('')),
                                    fit: BoxFit.cover
                                  ),
                                  color: Colors.purpleAccent
                                ),
                              ),
                              onTap: () {
                                getImage();
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
                              ref.read(userStoreProvider.notifier).updateProfile(
                                User(
                                  name: _name.text,
                                  aboutMe: _aboutMe.text,
                                  speciality: _speciality.text,
                                  username: _username.text,
                                  password: _password.text,
                                  image: _imageFile == null ? null : getStringImage(_imageFile!)
                                )
                              );
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
      ],
    );
  }
}

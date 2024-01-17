import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/auth/model/user.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStoreProvider);

    File? _imageFile;
    late TextEditingController name =
        TextEditingController(text: user.value!.name);
    late TextEditingController aboutMe =
        TextEditingController(text: user.value!.aboutMe);
    late TextEditingController speciality =
        TextEditingController(text: user.value!.speciality);
    late TextEditingController username =
        TextEditingController(text: user.value!.username);
    late TextEditingController password =
        TextEditingController(text: user.value!.password);
    late TextEditingController confirmPassword =
        TextEditingController(text: user.value!.password);
    GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile',
              style: Theme.of(context).textTheme.titleMedium!),
          actions: [
            IconButton(
              onPressed: () {
                User updatedUser = User(
                  id: user.value!.id,
                  name: name.text,
                  aboutMe: aboutMe.text,
                  speciality: speciality.text,
                  username: username.text,
                  password: password.text,
                );
                ref.read(userStoreProvider.notifier).updateProfile(updatedUser);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
            )
          ],
        ),
        body: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[200],
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(Icons.camera_alt),
                                              title: Text('Camera'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.photo_album),
                                              title: Text('Gallery'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //create a forms for update user
                        Column(
                          children: [
                            TextFormField(
                              decoration: kInputDecoration('Name'),
                              controller: name,
                              validator: (val) =>
                                  val!.isEmpty ? 'Invalid Name' : null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: kInputDecoration('About Me'),
                              controller: aboutMe,
                              validator: (val) =>
                                  val!.isEmpty ? 'Invalid About Me' : null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: kInputDecoration('Speciality'),
                              controller: speciality,
                              validator: (val) =>
                                  val!.isEmpty ? 'Invalid Speciality' : null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: kInputDecoration('Username'),
                              controller: username,
                              validator: (val) =>
                                  val!.isEmpty ? 'Invalid Username' : null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // TextFormField(
                            //   decoration: kInputDecoration('Password'),
                            //   controller: password,
                            //   validator: (val) =>
                            //       val!.isEmpty ? 'Invalid Password' : null,
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // TextFormField(
                            //   decoration: kInputDecoration('Confirm Password'),
                            //   controller: confirmPassword,
                            //   validator: (val) {
                            //     if (val!.isEmpty) {
                            //       return 'Invalid Confirm Password';
                            //     }
                            //     if (val != password.text) {
                            //       return 'Passwords do not match';
                            //     }
                            //     return null;
                            //   },
                            // ),
                          ],
                        )
                      ]),
                ))));
  }
}

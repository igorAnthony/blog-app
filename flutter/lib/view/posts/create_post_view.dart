import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/post.dart';
import 'package:flutter_blog_app/services/post_service.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostView extends StatefulWidget {
  final Post? post;
  final String? title;

  const CreatePostView({super.key, this.post, this.title});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late final TextEditingController _postBody;
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  void _createPost() async{
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createPost(_postBody.text, image);

    if(response.error == null){
      Navigator.of(context).pop();
    }
    else if(response.error == unauthorized){
      navigatorPushNamedAndRemoveUntil(context, loginRoute);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  void _editPost(int postId) async{
    
    ApiResponse response = await editPost(postId, _postBody.text);

    if(response.error == null){
      Navigator.of(context).pop();
    }
    else if(response.error == unauthorized){
      navigatorPushNamedAndRemoveUntil(context, loginRoute);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  
  @override
  void initState() {
    _postBody = TextEditingController();
    if(widget.post != null){
      _postBody.text = widget.post!.body ?? '';
    }
    super.initState();
  }
  @override
  void dispose() {
    _postBody.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? "Add new post" : "${widget.title}"),
      ),
      body: _loading ? const Center(child: CircularProgressIndicator()) : ListView(
        children: [
          widget.post != null ? const SizedBox() :
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            decoration: BoxDecoration(
              image: _imageFile == null ? null : DecorationImage(
                image: FileImage(_imageFile ?? File('')),
                fit: BoxFit.cover
              ),
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.image, size:50, color:Colors.black38),
                onPressed: () {
                  getImage();
                },
              ),
            ),
          ),
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _postBody,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                validator: (value) => value!.isEmpty ? 'Post body is required' : null,
                decoration: const InputDecoration(
                  hintText: "Post body...",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color:Colors.black38))
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: kTextButton("Post", (){
              if(_formkey.currentState!.validate()){
                setState(() {
                  _loading = !_loading;
                });
                if(widget.post == null)
                {
                  _createPost();
                }
                else{
                  _editPost(widget.post!.id ?? 0);
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
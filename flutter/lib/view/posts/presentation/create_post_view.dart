import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/post.dart';
import 'package:flutter_blog_app/services/post_service.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:flutter_blog_app/view/posts/presentation/custom_text_field_widget.dart';
import 'package:flutter_quill/flutter_quill.dart';
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
  late final TextEditingController _postTitle;
  final QuillController _textEditorController = QuillController.basic();

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
    _postTitle = TextEditingController();
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
        title: Text(widget.title == null ? "Add new post" : "${widget.title}", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: _loading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //row to add image
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: _imageFile == null ? null : DecorationImage(
                        image: FileImage(_imageFile ?? File('')),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100]
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
                  //add plus button
                  const SizedBox(width: 10,),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.add, size:50, color:Colors.black38),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                title: 'Title',
                hintText: "Start typing...",
                controller: _postTitle,
                validator: (value) => value!.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 10,),
              const CustomTitle(title: 'Write your article'),
              const SizedBox(height: 10,),
              QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: _textEditorController,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('pt', 'BR'),
                  ),
                  showDividers: false,
                  showSmallButton: false,
                  showInlineCode: false,
                  showColorButton: true,
                  showBackgroundColorButton: false,
                  showClearFormat: false,
                  showAlignmentButtons: false,
                  showLeftAlignment: false,
                  showCenterAlignment: false,
                  showRightAlignment: false,
                  showJustifyAlignment: false,
                  showHeaderStyle: true,
                  showListCheck: false,
                  showCodeBlock: false,
                  showQuote: false,
                  showIndent: false,
                  showLink: false,
                  showUndo: false,
                  showRedo: false,
                  showDirection: false,
                  showSearchButton: true,
                  showSubscript: false,
                  showSuperscript: false,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100]
                  ),
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: _textEditorController,
                      readOnly: false,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('pt', 'BR'),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 10,),

              
            ],
          ),
        ),
      ),
    );
  }
}//widget.post != null ? const SizedBox() :
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 400,
          //   decoration: BoxDecoration(
          //     image: _imageFile == null ? null : DecorationImage(
          //       image: FileImage(_imageFile ?? File('')),
          //       fit: BoxFit.cover
          //     ),
          //   ),
          //   child: Center(
          //     child: IconButton(
          //       icon: const Icon(Icons.image, size:50, color:Colors.black38),
          //       onPressed: () {
          //         getImage();
          //       },
          //     ),
          //   ),
          // ),
          // Form(
          //   key: _formkey,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8),
          //     child: TextFormField(
          //       controller: _postBody,
          //       keyboardType: TextInputType.multiline,
          //       maxLines: 9,
          //       validator: (value) => value!.isEmpty ? 'Post body is required' : null,
          //       decoration: const InputDecoration(
          //         hintText: "Post body...",
          //         border: OutlineInputBorder(borderSide: BorderSide(width: 1, color:Colors.black38))
          //       ),
          //     ),
          //   )
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8),
          //   child: kTextButton("Post", (){
          //     if(_formkey.currentState!.validate()){
          //       setState(() {
          //         _loading = !_loading;
          //       });
          //       if(widget.post == null)
          //       {
          //         _createPost();
          //       }
          //       else{
          //         _editPost(widget.post!.id ?? 0);
          //       }
          //     }
          //   },
              
          //   ),
          // ),
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_blog_app/features/posts/store/posts_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/custom_text_field_widget.dart';
import 'package:flutter_blog_app/utils/utils.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostView extends ConsumerStatefulWidget {
  final Post? post;
  final String? title;

  const CreatePostView({super.key, this.post, this.title});

  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends ConsumerState<CreatePostView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
  // void _createPost() async{
  //   String? image = _imageFile == null ? null : getStringImage(_imageFile);
  //   Post post = Post();
  //   post.title = _postTitle.text;
  //   post.body = _textEditorController.document.toPlainText();
  //   post.image = image;
    
  //   ApiResponse response = await createPost(post);

  //   if(response.error == null){
  //     Navigator.of(context).pop();
  //   }
  //   else if(response.error == unauthorized){
  //     navigatorPushNamedAndRemoveUntil(context, loginRoute);
  //   }
  //   else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}')
  //     ));
  //     setState(() {
  //       _loading = !_loading;
  //     });
  //   }
  // }

  // void _editPost(int postId) async{
    
  //   //ApiResponse response = await editPost(postId, _postBody.text);

  //   if(response.error == null){
  //     Navigator.of(context).pop();
  //   }
  //   else if(response.error == unauthorized){
  //     navigatorPushNamedAndRemoveUntil(context, loginRoute);
  //   }
  //   else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}')
  //     ));
  //     setState(() {
  //       _loading = !_loading;
  //     });
  //   }
  // }

  
  @override
  void initState() {
    _postTitle = TextEditingController();

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? "Add new post" : "${widget.title}", style: Theme.of(context).textTheme.titleMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
                Post post = Post();
                post.title = _postTitle.text;
                post.body = _textEditorController.document.toDelta().toJson();
                post.image = _imageFile == null ? null : getStringImage(_imageFile!);
                switch(await ref.read(postsStoreProvider().notifier).createPost(post))
                {
                  case '200':
                    Navigator.of(context).pop();
                    break;
                  case '401':
                    navigatorPushNamedAndRemoveUntil(context, loginRoute);
                    break;
                  default:
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error')
                    ));
                    break;
                }

                

            },
          )
        ],
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
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
}
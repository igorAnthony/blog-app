import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/post.dart';
import 'package:flutter_blog_app/services/post_service.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:flutter_blog_app/view/posts/comment_view.dart';
import 'package:flutter_blog_app/view/posts/create_post_view.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  Future<void> retrievePosts() async{
    userId = await getUserId();
    ApiResponse response = await getPost();
    if(response.error == null){
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if(response.error == unauthorized){
      logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  void _likeDislike(int postId) async {
    ApiResponse response = await likeUnlikePost(postId);
    if(response.error == null){
      retrievePosts();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  void _deletePost(int postId) async {
    ApiResponse response = await deletePost(postId);
    if(response.error == null){
      retrievePosts();
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
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? const Center(child: CircularProgressIndicator(),) : 
      RefreshIndicator(
        onRefresh: () {
          return retrievePosts();
        },
        child: ListView.builder(
          itemCount: _postList.length,
          itemBuilder: (context, index) {
            Post post = _postList[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                image: post.user!.image != null ?
                                  DecorationImage(image: NetworkImage('${post.user!.image}'), fit: BoxFit.cover) : null,
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.amber
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('${post.user!.name}',
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize:18),
                              
                            ),
                          ],
                        ),
                      ),
                      post.user!.id == userId ?
                      PopupMenuButton( 
                          child: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.more_vert, color: Colors.black),
                          ),
                          itemBuilder:(context) => [
                            const PopupMenuItem(
                              value:'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value:'delete', 
                              child: Text('Delete'),
                            ),
                          ],  
                          onSelected:(value) {
                            if(value == 'edit'){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatePostView(
                                title: 'Edit Post', 
                                post:post,
                              )));
                            }else{
                              _deletePost(post.id ?? 0) ;
                            }
                          },        
                      ) : const SizedBox()
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Text('${post.body}'),
                  post.image != null ? 
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${post.image}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ) : SizedBox(height: post.image != null ? 0 : 10,),
                  Row(
                    children: [
                      kLikeAndComment(
                        post.likesCount ?? 0, 
                        post.selfLiked == true ? Icons.favorite : Icons.favorite_outline, 
                        post.selfLiked == true ? Colors.red : Colors.black38,
                        (){
                          _likeDislike(post.id ?? 0);
                        }
                      ),
                      Container(
                        height: 25,
                        width: 0.5,
                        color: Colors.black38,
                      ),
                      kLikeAndComment(
                        post.commentsCount ?? 0, 
                        Icons.sms_outlined, 
                        Colors.black54,
                        (){
                          Navigator.of(context).push(MaterialPageRoute(builder: ((context) => CommentView(postId: post.id,))));
                        }
                      ),
                    ],
                  ),
                  Container(
                    height: 0.5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black38,
                  ),
                ],
              )
            );
          },
        ),
      );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/api.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/constant/route.dart';
import 'package:flutter_blog_app/models/api_response.dart';
import 'package:flutter_blog_app/models/post.dart';
import 'package:flutter_blog_app/services/post_service.dart';
import 'package:flutter_blog_app/services/user_service.dart';
import 'package:flutter_blog_app/view/posts/widgets/explore_section_widget.dart';
import 'package:flutter_blog_app/view/posts/widgets/header_content_widget.dart';
import 'package:flutter_blog_app/view/posts/widgets/post_widget.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getPost();
    if (response.error == null) {
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then(
          (value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _likeDislike(int postId) async {
    ApiResponse response = await likeUnlikePost(postId);
    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then(
          (value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _deletePost(int postId) async {
    ApiResponse response = await deletePost(postId);
    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then(
          (value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Color.fromARGB(255, 253, 250, 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderContent(),
                const ExploreSection(),
                RefreshIndicator(
                  onRefresh: () {
                    return retrievePosts();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              const Text("Latest News",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500)),
                              kTextButton('More', () {}, style: Theme.of(context).textTheme.titleSmall!)
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height - 450,
                            child: ListView.builder(
                              itemCount: _postList.length,
                              itemBuilder: (context, index) {
                                Post post = _postList[index];
                                return PostWidget(
                                  post: post,
                                  onLikeDislike: (postId) {
                                    _likeDislike(postId);
                                  });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

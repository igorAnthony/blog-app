import 'package:flutter_blog_app/features/posts/store/posts_repository.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_store.g.dart';

@Riverpod()
class PostsStore extends _$PostsStore{
  late PostsRepository _postsRepository;
  bool loading = false;

  @override
  Future<List<Post>> build({int? categoryId}) async {
    loading = true;
    _postsRepository = PostsRepository();
    List<Post> posts  = await _postsRepository.getPosts(categoryId: categoryId);
    print("chegeu aq");
    print("posts passei aq: $posts");
    loading = false;
    return posts;
  }

  //create post
  Future<void> createPost(Post post) async {
    _postsRepository = PostsRepository();
    List<Post> posts = state.value!;
    state = AsyncValue.data(posts);
    await _postsRepository.createPost(post);
    state.value!.add(post);
  }

  //delete post
  Future<void> deletePost(int postId) async {
    _postsRepository = PostsRepository();
    List<Post> posts = state.value!;
    state = AsyncValue.data(posts);
    await _postsRepository.deletePost(postId);
    state.value!.removeWhere((element) => element.id == postId);
  }

  //like or dislike post
  Future<void> likeDislikePost(int index) async {
    _postsRepository = PostsRepository();
    List<Post> posts = state.value!;
    posts[index].likesCount = posts[index].likesCount! + 1;
    await _postsRepository.likeDislikePost(posts[index].id!);
    state = AsyncValue.data(posts);    
  }

  //edit post
  Future<void> editPost(Post newPost, int index) async {
    _postsRepository = PostsRepository();
    List<Post> posts = state.value!;
    posts[index] = newPost;
    await _postsRepository.editPost(newPost);
    state = AsyncValue.data(posts);
  }

  //get posts
  Future<void> getPosts() async {
    loading = true;
    _postsRepository = PostsRepository();
    List<Post> posts  = await _postsRepository.getPosts();
    state = AsyncValue.data(posts);
    loading = false;
  }
}
import 'package:flutter_blog_app/features/comments/comment_model.dart';
import 'package:flutter_blog_app/features/comments/store/comments_repository.dart';
import 'package:flutter_blog_app/utils/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comments_store.g.dart';

@Riverpod()
class CommentsStore extends _$CommentsStore{
  late CommentsRepository _commentRepository;

  @override
  Future<List<Comment>> build(int postId) async {
    _commentRepository = CommentsRepository();
    ApiResponse apiResponse  = await _commentRepository.getComments(postId);
    List<Comment> comments = apiResponse.data as List<Comment>;
    return comments;
  }

  //edit my comment

  Future<void> editComment(String newComment, int index) async {
    _commentRepository = CommentsRepository();
    List<Comment> comments = state.value!;
    state = AsyncValue.data(comments);
    await _commentRepository.editComment(comments[index], newComment);
    comments[index].comment = newComment;
  }

  //delete my comment
  Future<void> deleteComment(int index) async {
    _commentRepository = CommentsRepository();
    List<Comment> comments = state.value!;
    state = AsyncValue.data(comments);
    await _commentRepository.deleteComment(comments[index].id!);
    comments.removeAt(index);
  }

  //create comment
  Future<void> createComment(int postId, String? comment) async {
    _commentRepository = CommentsRepository();
    List<Comment> comments = state.value!;
    state = AsyncValue.data(comments);
    await _commentRepository.createComment(postId, comment);
    ApiResponse apiResponse  = await _commentRepository.getComments(postId);
    List<Comment> newComments = apiResponse.data as List<Comment>;
    state = AsyncValue.data(newComments);
  }

}
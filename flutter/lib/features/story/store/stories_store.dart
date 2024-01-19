import 'package:flutter_blog_app/features/story/model/story_model.dart';
import 'package:flutter_blog_app/features/story/store/story_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stories_store.g.dart';

@Riverpod()
class StoriesStore extends _$StoriesStore{
  late StoriesRepository _storiesRepository;
  bool loading = false;

  @override
  Future<List<Story>> build(int userId) async {
    loading = true;
    _storiesRepository = StoriesRepository();
    List<Story> stories  = await _storiesRepository.getStoryByUserId(userId);
    loading = false;
    return stories;
  }

  //create post
  Future<String> createStory(Story story) async {
    String responseStatus = await _storiesRepository.createStory(story);
    responseStatus == '200' ? state.value!.add(story) : null;
    return responseStatus;
  }

  //delete post
  Future<void> deleteStory(int storyId) async {
    await _storiesRepository.deleteStory(storyId);
    state.value!.removeWhere((element) => element.id == storyId);
  }
  List<Story> getFriendStories(int friendId){
    List<Story> stories = state.value!;
    return stories.where((element) => element.userId == friendId).toList();        
  }
}
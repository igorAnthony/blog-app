import 'package:flutter_blog_app/features/story/model/story_model.dart';

class ListStory {

  int? userId;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  String? name;
  List<Story>? stories;

  ListStory({
    this.userId,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.stories,
  });

  factory ListStory.fromJson(Map<String, dynamic> json) {
    return ListStory(
      userId: json['id'],
      avatar: json['avatar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      stories: json['stories'] != null ? (json['stories'] as List).map((p) => Story.fromJson(p)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'avatar': avatar,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'stories': stories,
    };
  }

  List<Story> getStories() {
    return stories!;
  }

  //remove where story_id == storyId
  void removeStory(int storyId) {
    stories!.removeWhere((element) => element.id == storyId);
  }

  //add story
  void add(Story story) {
    stories!.add(story);
  }

  //set stories
  void setStories(List<Story> stories) {
    this.stories = stories;
  }  

  

  
}
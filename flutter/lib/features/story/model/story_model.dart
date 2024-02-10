class Story {
  final int? id;
  final int? userId;
  final String? image;
  final DateTime? createdAt;
  final bool? isViewed;

  Story({
    this.id,
    this.userId,
    this.image,
    this.createdAt,
    this.isViewed,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    /*{id: 1, user_id: 1, image: http://192.168.1.6:8000/storage/stories/photo1.jpeg, created_at: 2024-02-03T18:40:28.000000Z, updated_at: 2024-02-03T18:40:28.000000Z}*/
    return Story(
      id: json['id'],
      userId: json['user_id'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'image': image,
      'created_at': createdAt,
    };
  }
}
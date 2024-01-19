class Story {
  final int? id;
  final String? name;
  final String? imageUrl;
  final int? userId;
  final bool? isViewed;

  const Story({
    this.id,
    this.name,
    this.imageUrl,
    this.userId,
    this.isViewed,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      userId: json['userId'] as int,
      isViewed: json['isViewed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'userId': userId,
      'isViewed': isViewed,
    };
  }
}
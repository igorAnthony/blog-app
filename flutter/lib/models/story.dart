class Story {
  final String? name;
  final String? imageUrl;
  final int? id;
  final bool? isViewed;

  const Story({
    required this.name,
    required this.imageUrl,
    this.id,
    this.isViewed,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      id: json['id'] as int,
      isViewed: json['isViewed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'id': id,
      'isViewed': isViewed,
    };
  }
}
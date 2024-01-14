class Category {
  final String name;
  final String image;
  final String description;
  final int id;

  Category({
    required this.name,
    required this.image,
    required this.description,
    required this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'id': id,
    };
  }
}
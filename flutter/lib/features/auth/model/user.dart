class User {
  int? id;
  String? name;
  String? username;
  String? aboutMe;
  String? image;
  String? email;
  String? speciality;
  String? createdAt;
  String? updatedAt;
  String? password;
  List<User>? followers;
  List<User>? following;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.username,
    this.aboutMe,
    this.speciality,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.followers,
    this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      aboutMe: json['about_me'],
      speciality: json['speciality'],
      username: json['username'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      password: json['password'],
      followers: json['followers'] != null ? (json['followers'] as List).map((i) => User.fromJson(i)).toList() : null,
      following: json['following'] != null ? (json['following'] as List).map((i) => User.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'email': email,
      'aboutMe': aboutMe,
      'speciality': speciality,
      'username': username,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'password': password,
      'followers': followers,
      'following': following,
    };
  }
}

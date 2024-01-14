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
    };
  }
}

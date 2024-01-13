class User {
  int? id;
  String? name;
  String? username;
  String? aboutMe;
  String? image;
  String? email;
  String? token;
  String? speciality;
  String? createdAt;
  String? updatedAt;
  String? password;

  User(
    {
      this.id, 
      this.name,
      this.image, 
      this.email, 
      this.token,
      this.username,
      this.aboutMe,
      this.speciality,
      this.password,
      this.createdAt,
      this.updatedAt,
    }
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      aboutMe: json['user']['about_me'],
      speciality: json['user']['speciality'],
      username: json['user']['username'],
      createdAt: json['user']['created_at'],
      updatedAt: json['user']['updated_at'],
      password: json['user']['password'],
      token: json['token'],
    );
  }
  factory User.toJson(User user){
    return User(
      id: user.id,
      name: user.name,
      image: user.image,
      email: user.email,
      aboutMe: user.aboutMe,
      speciality: user.speciality,
      username: user.username,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      password: user.password,
      token: user.token,
    );
  }
}
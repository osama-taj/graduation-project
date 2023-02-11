class user {
  int? id;
  String? name;
  String? email;
  String? password;
  String? image;
  String? username;
  String? user_type;
  String? description;
  String? departement_id;
  String? token;

  user(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.image,
      this.username,
      this.user_type,
      this.description,
      this.departement_id,
      this.token});

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      password: json['user']['password'],
      image: json['user']['image'],
      username: json['user']['username'],
      user_type: json['user']['user_type'],
      description: json['user']['description'],
      departement_id: json['user']['departement_id'],
      token: json['token'],
    );
  }
}

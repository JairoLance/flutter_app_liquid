class User {
  int userId;
  String username;
  String name;
  String password;
  String email;
  String tokens;

  User();

  User.add(
      {this.userId,
      this.username,
      this.name,
      this.password,
      this.email,
      this.tokens});

  User copyWith(
      {int userId,
      String username,
      String name,
      String password,
      String email,
      String tokens}) {


    return User.add(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        name: name ?? this.name,
        password: password ?? this.password,
        email: email ?? this.email,
        tokens: tokens ?? this.tokens
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User.add(
      userId: json["id_usuario"],
      username: json["usuario"],
      name: json["nome"],
      password: json["senha"],
      email: json["email"],
      tokens: json["tokens"]);

  Map<String, dynamic> toJson() => {
        "id_usuario": userId,
        "usuario": username,
        "nome": name,
        "senha": password,
        "email": email,
        "tokens": tokens
      };

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, name: $name, password: $password, email: $email}';
  }
}

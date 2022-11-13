class Auth {
  int? id;
  String? login;
  String? nome;
  String? roles;
  String? token;

  Auth({this.id, this.login, this.nome, this.roles, this.token});

  Auth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    roles = json['roles'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['roles'] = this.roles;
    data['token'] = this.token;
    return data;
  }
}

class Login {
  String? login;
  String? senha;

  Login({
    this.login,
    this.senha,
  });

  toJson() {
    var data = <String, dynamic>{};
    data["login"] = login ?? "";
    data["senha"] = senha ?? "";
    return data;
  }
}

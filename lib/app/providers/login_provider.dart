import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:products/app/entities/auth.dart';
import 'package:products/app/entities/login.dart';
import 'package:products/app/pages/products.dart';
import 'package:products/app/services/login_service.dart';

class LoginProvider with ChangeNotifier {
  Login login = Login();
  Auth auth = Auth();
  bool admin = false;
  final LoginService _loginService = LoginService();

  bool succcess = false;

  setAdmin(auth) {
    admin = auth?.roles != null && auth!.roles!.contains("ADMIN");
  }

  authenticate(String user, String password, context) async {
    setLogin(user);
    setSenha(password);
    auth = await _loginService.auth(login);
    if (auth != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductsPage()),
      );
      succcess = true;
    } else {
      succcess = false;
    }

    notifyListeners();
  }

  setLogin(value) {
    login?.login = value;
    notifyListeners();
  }

  setSenha(value) {
    login?.senha = value;
    notifyListeners();
  }
}

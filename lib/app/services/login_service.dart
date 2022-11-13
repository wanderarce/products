import 'package:products/app/entities/login.dart';
import 'package:products/app/repositories/login_repositories.dart';

class LoginService {
  final LoginRepository _loginRepository = LoginRepository();

  auth(Login login) async {
    return await _loginRepository.auth(login.toJson());
  }
}

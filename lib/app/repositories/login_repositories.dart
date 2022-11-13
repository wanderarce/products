import 'package:dio/dio.dart';
import 'package:products/app/entities/auth.dart';

class LoginRepository {
  Dio dio = Dio();

  Future<dynamic> auth(json) async {
    dio.options.baseUrl = 'https://pwndb.herokuapp.com/';
    Response response = await dio.post("seguranca/login", data: json);
    if (response.statusCode == 200) {
      Auth auth = Auth.fromJson(response.data);
      return auth;
    }
    return null;
  }
}

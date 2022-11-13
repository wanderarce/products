import 'package:dio/dio.dart';
import 'package:products/app/entities/alert.dart';
import 'package:products/app/entities/products.dart';

class ProductsRepository {
  Dio dio = Dio();
  List<Products> products = [];
  Future<dynamic> fetchProducts(token) async {
    dio.options.baseUrl = 'https://pwndb.herokuapp.com/';
    dio.options.headers = {'Authorization': "Bearer $token"};
    Response response = await dio.get("api/produtos");
    products.clear();
    if (response.statusCode == 200) {
      products =
          List.from(response.data).map((e) => Products.fromJson(e)).toList();
    }
    return products;
  }

  add(Map<String, dynamic> json, token) async {
    dio.options.baseUrl = 'https://pwndb.herokuapp.com/';
    dio.options.headers = {'Authorization': "Bearer $token"};
    Response response = await dio.post("api/produtos", data: json);
    if (response.statusCode == 201) {
      return Alert.success(response.data['message']);
    } else {
      return Alert.error(response.data["message"]);
    }
  }

  edit(int? id, Map<String, dynamic> json, token) async {
    dio.options.baseUrl = 'https://pwndb.herokuapp.com/';
    dio.options.headers = {'Authorization': "Bearer $token"};
    Response response = await dio.put("api/produtos/$id", data: json);
    if (response.statusCode == 200) {
      return Alert.success(response.data['message']);
    } else {
      return Alert.error(response.data["message"]);
    }
  }

  fetchProduct(int? id, String? token) async {
    dio.options.baseUrl = 'https://pwndb.herokuapp.com/';
    dio.options.headers = {'Authorization': "Bearer $token"};
    Products? product;
    Response response = await dio.get("api/produtos/$id");
    if (response.statusCode == 200) {
      product = Products.fromJson(response.data);
    }
    return product;
  }

  Future<Alert> delete(int? id, String? token) async {
    dio.options.baseUrl = 'https://pwndb.herokuapp.com/';
    dio.options.headers = {'Authorization': "Bearer $token"};
    Response response = await dio.delete("api/produtos/$id");
    if (response.statusCode == 204) {
      return Alert.success("Item removido com sucess");
    } else {
      return Alert.error("Item não pode ser removido");
    }
  }
}

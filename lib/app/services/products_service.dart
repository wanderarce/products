import 'package:products/app/entities/alert.dart';
import 'package:products/app/entities/products.dart';
import 'package:products/app/repositories/products_repositories.dart';

class ProductsService {
  final ProductsRepository _productsRepository = ProductsRepository();

  fetchProducts(String token) async {
    return await _productsRepository.fetchProducts(token);
  }

  Future<Alert> add(Products product, String token) async {
    return await _productsRepository.add(product.toJson(), token);
  }

  Future<Products> fetchProduct(int? id, String? token) async {
    return await _productsRepository.fetchProduct(id, token);
  }

  deleteProduct(int? id, String? token) async {
    return await _productsRepository.delete(id, token);
  }

  Future<Alert> edit(int? id, Products product, String? token) async {
    return await _productsRepository.edit(id, product.toJson(), token);
  }
}

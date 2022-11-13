import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:products/app/entities/alert.dart';
import 'package:products/app/entities/products.dart';
import 'package:products/app/services/products_service.dart';

class ProductsEditProvider with ChangeNotifier {
  Products product = Products();
  final ProductsService _productsService = ProductsService();
  bool loading = false;

  setLoading(bool loading) {
    this.loading = loading;
  }

  Future<Products> fetchProduct(int? id, String? token) async {
    setLoading(true);
    product = await _productsService.fetchProduct(id, token);
    setLoading(false);
    return product;
  }

  Future<Alert> edit(int? id, Products product, String? token) async {
    setLoading(true);
    Alert alert = await _productsService.edit(id, product, token);
    setLoading(false);
    return alert;
  }
}

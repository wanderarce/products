import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:products/app/entities/products.dart';
import 'package:products/app/services/products_service.dart';

import '../entities/alert.dart';

class ProductsProvider with ChangeNotifier {
  List<dynamic> products = [];
  final ProductsService _productsService = ProductsService();
  bool loading = false;

  setLoading(bool loading) {
    this.loading = loading;
  }

  fetchProducts(String token) async {
    setLoading(true);
    products = await _productsService.fetchProducts(token);
    setLoading(false);
    notifyListeners();
  }

  delete(int? id, String? token) async {
    setLoading(true);
    Alert alert = await _productsService.deleteProduct(id, token);
    setLoading(false);
    return alert;
  }

  Future<Alert> add(Products product, token) async {
    setLoading(false);
    Alert alert = await _productsService.add(product, token);
    setLoading(false);
    return alert;
  }
}

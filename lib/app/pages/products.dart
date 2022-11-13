import 'package:flutter/material.dart';
import 'package:products/app/components/dialog_component.dart';
import 'package:products/app/entities/alert.dart';
import 'package:products/app/entities/auth.dart';
import 'package:products/app/entities/products.dart';
import 'package:products/app/pages/product_add.dart';
import 'package:products/app/pages/product_edit.dart';
import 'package:products/app/providers/login_provider.dart';
import 'package:products/app/providers/products_provider.dart';
import 'package:products/app/services/format_service.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Auth? auth;

  @override
  void initState() {
    super.initState();
    auth = context.read<LoginProvider>().auth;
    if (auth != null) {
      context.read<ProductsProvider>().fetchProducts(auth!.token!);
    }
  }

  isAdmin() {
    context.read<LoginProvider>().setAdmin(auth);
    return context.read<LoginProvider>().admin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductAddPage()),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    child: Text(auth?.nome ?? ""),
                  ),
                  context.watch<ProductsProvider>().loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              context.watch<ProductsProvider>().products.length,
                          itemBuilder: (_, index) {
                            Products product = context
                                .read<ProductsProvider>()
                                .products[index];

                            return Card(
                              child: ListTile(
                                title: Text(product?.marca ?? ""),
                                trailing: Text(
                                    FormatService().currency(product.valor)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(product.descricao ?? ""),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (auth != null && isAdmin())
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductEditPage(
                                                              id: product?.id)),
                                                );
                                              },
                                              child: const Text("Editar")),
                                        if (auth != null && isAdmin())
                                          TextButton(
                                              onPressed: () async {
                                                Alert alert = await Provider.of<
                                                            ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .delete(product.id,
                                                        auth?.token!);
                                                await DialogsComponent
                                                    .defaultDialog(
                                                        context,
                                                        alert.title,
                                                        alert.message,
                                                        Colors.black);
                                                if (alert.success) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductsPage()),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                "Remover",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void fecthProdcuts(String? token, context) {
    if (token != null) {
      var productProvider = Provider.of<ProductsProvider>(context);
      productProvider.fetchProducts(token);
    }
  }
}

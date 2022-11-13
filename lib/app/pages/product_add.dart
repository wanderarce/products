import 'package:flutter/material.dart';
import 'package:products/app/components/dialog_component.dart';
import 'package:products/app/entities/alert.dart';
import 'package:products/app/entities/auth.dart';
import 'package:products/app/entities/products.dart';
import 'package:products/app/pages/products.dart';
import 'package:products/app/providers/login_provider.dart';
import 'package:products/app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({Key? key}) : super(key: key);

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  Auth? auth;

  var textEditMarcaController = TextEditingController();
  var textEditDescricaoController = TextEditingController();
  var textEditValorController = TextEditingController();
  var formProductAdd = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    auth = context.read<LoginProvider>().auth;
  }

  @override
  void dispose() {
    super.dispose();
    textEditMarcaController.dispose();
    textEditDescricaoController.dispose();
    textEditValorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Form(
                key: formProductAdd,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: textEditMarcaController,
                      decoration: InputDecoration(hintText: "Marca"),
                    ),
                    TextFormField(
                      controller: textEditDescricaoController,
                      decoration: InputDecoration(hintText: "Descrição"),
                    ),
                    TextFormField(
                      controller: textEditValorController,
                      decoration: InputDecoration(hintText: "Valor"),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formProductAdd.currentState!.validate()) {
                            var p = Products(
                                marca: textEditMarcaController.text,
                                descricao: textEditDescricaoController.text,
                                valor:
                                    double.parse(textEditValorController.text));
                            Alert alert = await Provider.of<ProductsProvider>(
                                    context,
                                    listen: false)
                                .add(p, auth!.token!);
                            await DialogsComponent.defaultDialog(context,
                                alert.title, alert.message, Colors.black);
                            if (alert.success) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProductsPage()),
                              );
                            }
                          }
                        },
                        child: Text("Enviar"))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:products/app/components/dialog_component.dart';
import 'package:products/app/entities/alert.dart';
import 'package:products/app/entities/auth.dart';
import 'package:products/app/entities/products.dart';
import 'package:products/app/pages/products.dart';
import 'package:products/app/providers/login_provider.dart';
import 'package:products/app/providers/products_edit_provider.dart';
import 'package:products/app/services/platfrom_service.dart';
import 'package:provider/provider.dart';

class ProductEditPage extends StatefulWidget {
  final int? id;
  const ProductEditPage({Key? key, this.id}) : super(key: key);

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  Auth? auth;

  final PlatformService _platformService = PlatformService();

  var textEditMarcaController = TextEditingController();
  var textEditDescricaoController = TextEditingController();
  var textEditValorController = TextEditingController();
  var formProductAdd = GlobalKey<FormState>();

  Products product = Products();

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
    Size size = MediaQuery.of(context).size;
    fetchProduct(auth);
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
              child: SizedBox(
                width: _platformService.isMobilePlatform()
                    ? size.width
                    : size.width / 2,
                child: Form(
                  key: formProductAdd,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: textEditMarcaController,
                        decoration: const InputDecoration(hintText: "Marca"),
                      ),
                      TextFormField(
                        controller: textEditDescricaoController,
                        decoration:
                            const InputDecoration(hintText: "Descrição"),
                      ),
                      TextFormField(
                        controller: textEditValorController,
                        decoration: const InputDecoration(hintText: "Valor"),
                      ),
                      SizedBox(width: size.width, height: 15),
                      ElevatedButton(
                          onPressed: () async {
                            if (formProductAdd.currentState!.validate()) {
                              product.marca = textEditMarcaController.text;
                              product.descricao =
                                  textEditDescricaoController.text;
                              product.valor =
                                  double.parse(textEditValorController.text);
                              Alert alert =
                                  await Provider.of<ProductsEditProvider>(
                                          context,
                                          listen: false)
                                      .edit(product.id, product, auth!.token!);
                              await DialogsComponent.defaultDialog(context,
                                  alert.title, alert.message, Colors.black);
                              if (alert.success && mounted) {
                                gotToProducts(context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(size.width, 50)),
                          child: const Text("Enviar"))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  fetchProduct(Auth? auth) async {
    if (auth != null && widget.id != null) {
      context.read<ProductsEditProvider>().fetchProduct(widget.id, auth.token);
      setFormData();
    }
  }

  setFormData() {
    product = context.read<ProductsEditProvider>().product;
    textEditMarcaController.text = product.marca ?? "";
    textEditDescricaoController.text = product?.descricao ?? "";
    textEditValorController.text = product?.valor.toString() ?? "";
  }

  void gotToProducts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductsPage()),
    );
  }
}

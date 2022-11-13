import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:products/app/providers/login_provider.dart';
import 'package:products/app/services/platfrom_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formLoginKey = GlobalKey<FormState>();
  final PlatformService _platformService = PlatformService();
  var textEditControllerLogin = TextEditingController();
  var textEditControllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditControllerLogin.dispose();
    textEditControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: _platformService.isMobilePlatform() ? size.width : size.width / 2,
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formLoginKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "Login"),
              controller: textEditControllerLogin,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Informe o login";
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Senha"),
              controller: textEditControllerPassword,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Informe sua senha";
                }
              },
            ),
            SizedBox(width: size.width, height: 12),
            ElevatedButton(
              onPressed: () async {
                if (formLoginKey.currentState!.validate()) {
                  Provider.of<LoginProvider>(context, listen: false)
                      .authenticate(textEditControllerLogin.text,
                          textEditControllerPassword.text, context);
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                      _platformService.isMobilePlatform()
                          ? size.width
                          : size.width / 2,
                      50)),
              child: const Text("Enviar"),
            )
          ],
        ),
      ),
    );
  }
}

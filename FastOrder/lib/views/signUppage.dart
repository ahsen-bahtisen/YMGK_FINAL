import 'package:flutter/material.dart';

import '../services/authService.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "", password2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Email adresi"),
                ),
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alan gerekli";
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(label: Text("Şifre")),
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alan gerekli";
                  }
                  if (value.length < 8) {
                    return "Şifre en az 8 karakter olmalıdır";
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration:
                    const InputDecoration(label: Text("Şifreyi Doğrula")),
                onChanged: (value) {
                  password2 = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alan gerekli";
                  }
                  if (value.length < 8) {
                    return "Şifre en az 8 karakter olmalıdır";
                  }
                  if (value != password) {
                    return "Şifreler eşleşmiyor";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Row(
                              children: [
                                CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor),
                                const SizedBox(width: 10),
                                const Text('Hesap oluşturma'),
                              ],
                            )),
                          );
                          await AuthService().signUp(email, password);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          "Üye ol",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    widget.tabController.animateTo(0);
                  },
                  child: const Text("Zaten hesabınız var mı? Şimdi giriş yap!"))
            ],
          ),
        ),
      ),
    );
  }
}

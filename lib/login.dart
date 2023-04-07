import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'logout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final magic = Magic.instance;

  Future login({required String email}) async {
    try {
      debugPrint('Email: $email');

      var token = await magic.auth.loginWithEmailOTP(email: email);
      // var token = await magic.auth.loginWithMagicLink(email: email);

      debugPrint('Token: $token');

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LogoutPage(),
        ),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }

                        return null;
                      },
                      controller: _emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final messenger = ScaffoldMessenger.of(context);

                          await login(email: _emailController.text);

                          messenger.showSnackBar(
                            const SnackBar(content: Text('Check your email')),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
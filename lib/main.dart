import 'package:dapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:provider/provider.dart';

import 'services/auth.dart';

void main() {
  Magic.instance = Magic("API_KEY");

  runApp(
    ChangeNotifierProvider<AuthService>(
      create: (_) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          MaterialApp(
            title: 'Flutter Magic',
            theme: ThemeData(primarySwatch: Colors.green),
            home: const SplashScreen(),
          ),
          Magic.instance.relayer,
        ],
      ),
    );
  }
}

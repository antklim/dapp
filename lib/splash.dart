import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';
import 'logout.dart';
import 'services/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: Provider.of<AuthService>(context).isLoggedIn(),
        builder: (context, snapshot) {
          debugPrint('Snapshot has data: ${snapshot.hasData}');
          debugPrint('Snapshot: ${snapshot.data}');

          if (snapshot.hasData) {
            return snapshot.data! ? const LogoutPage() : const LoginPage();
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final magic = Magic.instance;

  Future logout() async {
    try {
      await magic.user.logout();

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future getUserInfo() async {
    try {
      var userInfo = await magic.user.getMetadata();
      var isLoggedIn = await magic.user.isLoggedIn();

      debugPrint('User Info: ${userInfo.toJson()}');
      debugPrint('User logged in: $isLoggedIn');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Successfully Logged In'),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: getUserInfo,
              child: const Text('Get user info'),
            ),
          ],
        ),
      ),
    );
  }
}
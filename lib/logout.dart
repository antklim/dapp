import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:provider/provider.dart';

import 'services/auth.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final magic = Magic.instance;

  Future logout() async {
    try {
      await Provider.of<AuthService>(context, listen: false).logout();

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future getUserInfo() async {
    try {
      var userInfo = await Provider.of<AuthService>(context, listen: false).getUser();

      debugPrint('User Info: $userInfo');
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
import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

class User {
  final String email;
  final String issuer;
  final String publicAddress;

  User({
    required this.email,
    required this.issuer,
    required this.publicAddress,
  });
}

class AuthService extends ChangeNotifier {
  final magic = Magic.instance;
  
  User? user;

  Future<User> _getUser() async {
    var magicUser = await magic.user.getMetadata();

    return User(
      email: magicUser.email!,
      issuer: magicUser.issuer!,
      publicAddress: magicUser.publicAddress!,
    );
  }

  Future<User?> getUser() async {
    if (await isLoggedIn()) {
      user = await _getUser();
    } else {
      user = null;
    }

    notifyListeners();

    return user;
  }

  Future<bool> isLoggedIn() => magic.user.isLoggedIn();

  Future<String> login({required String email}) async {
    var token = await magic.auth.loginWithEmailOTP(email: email);

    user = await _getUser();

    notifyListeners();

    return token;
  }

  Future<void> logout() async {
    await magic.user.logout();

    user = null;

    notifyListeners();
  }
}

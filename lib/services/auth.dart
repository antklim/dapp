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

class AuthService {
  final magic = Magic.instance;
  
  User? user;

  Future<User?> getUser() async {
    if (await isLoggedIn()) {
      var magicUser = await magic.user.getMetadata();

      user = User(
        email: magicUser.email!,
        issuer: magicUser.issuer!,
        publicAddress: magicUser.publicAddress!,
      );
    } else {
      user = null;
    }

    return user;
  }

  Future<bool> isLoggedIn() => magic.user.isLoggedIn();

  Future<String> login({required String email}) => 
    magic.auth.loginWithEmailOTP(email: email);

  Future<bool> logout() => magic.user.logout();
}

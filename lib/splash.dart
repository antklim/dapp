import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final magic = Magic.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: magic.user.isLoggedIn(),
        builder: (context, snapshot) {
          debugPrint('Snapshot has data: ${snapshot.hasData}');
          debugPrint('Snapshot: ${snapshot.data}');

          List<Widget> children;

          if (snapshot.hasData) {
            if (snapshot.data!) {              
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Result: ${snapshot.data} - navigate to home page'),
                ),
              ];
            } else {
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Result: ${snapshot.data} - navigate to login'),
                ),
              ];
            }
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../screens/splashscreen.dart';
import '../screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    final localStorage = LocalStorage('my_app_storage');
    await localStorage.ready;

    // Expecting 'loggedin' to be a bool or truthy value
    final isLoggedIn = localStorage.getItem('loggedin');
    return isLoggedIn == true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track Progress',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // or a loading spinner
          } else if (snapshot.hasData && snapshot.data == true) {
            return const MyHomePage();
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}


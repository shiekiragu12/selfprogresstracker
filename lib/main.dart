import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/splashscreen.dart';
import '../screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 Future<bool> checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('loggedin') ?? false;
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


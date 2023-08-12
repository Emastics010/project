import 'package:flutter/material.dart';
import 'package:work/welcomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Schedular',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
      },
    );
  }
}

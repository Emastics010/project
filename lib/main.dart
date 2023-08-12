import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:work/firebase_options.dart';
import 'package:work/home_page.dart';
import 'package:work/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Schedular',
      theme: ThemeData(),
      initialRoute: user == null ? '/' : '/home',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => const TodoApp(),
      },
    );
  }
}

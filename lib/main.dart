import 'package:StyleHub/page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StyleHub());
}

class StyleHub extends StatelessWidget {
  const StyleHub({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: page(),
      );
  }
}
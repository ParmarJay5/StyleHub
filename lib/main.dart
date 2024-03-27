import 'package:StyleHub/page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Users/Settings/theme.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const StyleHub());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Make sure to await the initialization
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const StyleHub(),
    ),
  );
}

class StyleHub extends StatelessWidget {
  const StyleHub({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const page(),
    );
  }
}

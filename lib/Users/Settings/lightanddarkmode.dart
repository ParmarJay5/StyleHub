import 'package:flutter/material.dart';

class LDScreen extends StatefulWidget {
  const LDScreen({super.key});

  @override
  State<LDScreen> createState() => _LDScreenState();
}

class _LDScreenState extends State<LDScreen> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        actions: <Widget>[
          Switch(
            value: isDarkMode,
            onChanged: (isOn) {
              isOn
                  ? _toggleTheme(ThemeMode.dark)
                  : _toggleTheme(ThemeMode.light);
            },
          ),
        ],
      ),


    );
  }
}

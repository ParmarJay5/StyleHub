import 'package:StyleHub/homeScreens/Profile/Settings/return.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:StyleHub/Users/Settings/theme.dart';
import 'package:StyleHub/homeScreens/Profile/Settings/contactUS.dart';
import 'package:StyleHub/homeScreens/Profile/Settings/needHelp.dart';
import 'package:StyleHub/homeScreens/Profile/Settings/terms.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 80,
              child: Card(
                child: Row(
                  children: [
                    const Text(" Change Your Theme color"),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: IconButton(
                        onPressed: () {
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                        },
                        icon: const Icon(Icons.brightness_4_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SettingItem(
              title: 'Terms & Conditions',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
              },
            ),
            SettingItem(
              title: 'Need Help?',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NeedHelpScreen()));
              },
            ),
            SettingItem(
              title: 'Return Policy',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReturnPolicyScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final Function onTap;

  const SettingItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

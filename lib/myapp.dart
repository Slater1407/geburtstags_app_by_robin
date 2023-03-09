import 'package:flutter/material.dart';
import 'package:geburtstags_app_by_robin/screens/birthday/birthdays.screen.dart';
import 'package:geburtstags_app_by_robin/screens/birthday/detail/birthday.detail.screen.dart';
import 'package:geburtstags_app_by_robin/screens/birthday/forms/birthday.form.dart';
import 'package:geburtstags_app_by_robin/screens/dashboard.screen.dart';
import 'package:geburtstags_app_by_robin/screens/settings.screen.dart';

import 'templates/template.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geburtstags App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Template.routeName,
      routes: {
        Template.routeName: (context) => const Template(),
        BirthdaysScreen.routeName: (context) => const BirthdaysScreen(),
        DashboardScreen.routeName: (context) => const DashboardScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        BirthdayDetailScreen.routeName: (context) =>
            const BirthdayDetailScreen(),
        BirthdayForm.routeName: (context) => const BirthdayForm(),
      },
    );
  }
}

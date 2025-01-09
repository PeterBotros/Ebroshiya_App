import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Add this import
import 'localization/custom_localizations.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'أبارشية القوصية ومير',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        CustomLocalizations.delegate,
      ],
      locale: null, // Use the device's locale
      home: const LoginPage(),
    );
  }
}

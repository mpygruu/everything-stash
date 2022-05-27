import 'package:flutter/material.dart';
import 'pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everything Stash',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Cairo',
      ),
      home: const MainPage(),
    );
  }
}

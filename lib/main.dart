import 'package:first/DataBase/DBoperationSub.dart';
import 'package:first/DataBase/DBoperations.dart';
import 'package:first/Screen/ListScreen.dart';
import 'package:first/Screen/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'Screen/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBopener();
  await DBopenerSub(); // Call DBopenerSub before running the app
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

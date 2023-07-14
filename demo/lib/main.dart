import 'package:demo/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  int _mcgpalette0PrimaryValue = 0xFF0CA948;
  MaterialColor mcgpalette0 = MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFE2F5E9),
    100: Color(0xFFB6E5C8),
    200: Color(0xFF86D4A4),
    300: Color(0xFF55C37F),
    400: Color(0xFF30B663),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF0AA241),
    700: Color(0xFF089838),
    800: Color(0xFF068F30),
    900: Color(0xFF037E21),
  });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: mcgpalette0,
      ),
      home: const WidgetTree(),
    );
  }
}

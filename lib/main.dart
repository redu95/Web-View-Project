import 'package:flutter/material.dart';
import 'package:web_view_proj/webview_screen.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:web_view_proj/webview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SafeArea(child: WebViewScreen()) ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}




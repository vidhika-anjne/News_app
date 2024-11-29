import 'package:flutter/material.dart';
import 'news_home_screen.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NewsHomeScreen(),
    );
  }
}


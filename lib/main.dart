import 'package:flutter/material.dart';
import 'news_home_screen.dart';

void main() {
  runApp(NewsApp());
}

// class NewsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'News App',
//       debugShowCheckedModeBanner: false, // Hides the debug banner
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: NewsHomeScreen(),
//     );
//   }
// }

class NewsApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<NewsApp> {
  bool isDarkMode = false; // Default theme is light mode.

  // Define theme data.
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: isDarkMode ? darkTheme : lightTheme, // Dynamic theme.
      home: NewsHomeScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}
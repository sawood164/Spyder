import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyder/models/playlist_provider.dart';
import 'pages/home_page.dart';
import 'themes/theme_provider.dart';

void main() {
  runApp(
   MultiProvider(
     providers: [
       ChangeNotifierProvider( create: (contex) => ThemeProvider()),
     ChangeNotifierProvider( create: (contex) => PlaylistProvider()),
   ],
     child: const MyApp(),
),
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData ,

    );
  }
}
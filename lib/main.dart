import 'package:flutter/material.dart';
import 'package:music_player/components/playlist_provider.dart';
import 'package:music_player/pages/home_page.dart';
import 'package:music_player/themes/theme_selector.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
          child: const MyApp(),
  )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

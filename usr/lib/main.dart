import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/screens/love_notes_screen.dart';
import 'package:couldai_user_app/screens/date_night_screen.dart';
import 'package:couldai_user_app/screens/gallery_screen.dart';
import 'package:couldai_user_app/screens/messages_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'For My Love',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63), // Romantic Pink/Red
          secondary: const Color(0xFFF48FB1),
          surface: const Color(0xFFFFF0F5), // Lavender Blush
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Default, but implies we want clean text
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFE91E63),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/love_notes': (context) => const LoveNotesScreen(),
        '/date_night': (context) => const DateNightScreen(),
        '/gallery': (context) => const GalleryScreen(),
        '/messages': (context) => const MessagesScreen(),
        // Add more routes for other features as we build them
      },
    );
  }
}
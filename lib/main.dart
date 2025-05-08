import 'package:flutter/material.dart';
import 'package:task_14/app_style.dart';
import 'package:task_14/audio_player_screen.dart';
import 'package:task_14/video_player_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.lightButtonColor,
            foregroundColor: AppStyles.lightButtonTextColor,
            textStyle: AppStyles.buttonText,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.darkButtonColor,
            foregroundColor: AppStyles.darkButtonTextColor,
            textStyle: AppStyles.buttonText,
          ),
        ),
      ),
      home: HomeScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: toggleTheme,
              child: Text(
                isDarkMode ? 'Change for light theme' : 'Change for dark theme',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoPlayerScreen(),
                  ),
                );
              },
              child: const Text('Watch video'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AudioPlayerScreen(),
                  ),
                );
              },
              child: const Text('Listen audio'),
            ),
          ],
        ),
      ),
    );
  }
}

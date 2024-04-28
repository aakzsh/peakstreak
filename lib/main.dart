import 'package:flutter/material.dart';
import 'package:peakstreak/screens/welcome.dart';
import 'package:peakstreak/utils/theme_builder.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PeakStreak",
      home: const Welcome(),
      theme: buildTheme(Brightness.dark),
    );
  }
}
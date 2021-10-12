import 'package:flutter/material.dart';
import 'AchievementListPage.dart';

void main() {
  runApp(AchievementListApp());
}

class AchievementListApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Achievement List",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AchievementListPage(),
    );
  }
}


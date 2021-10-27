import 'package:flutter/material.dart';
import 'achievement_list_page.dart';

void main() {
  runApp(const AchievementListApp());
}

class AchievementListApp extends StatelessWidget {
  // Keyはデフォルトnull。
  // Widgetを識別する場合に指定する。
  const AchievementListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Achievement List",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AchievementListPage(),
    );
  }
}

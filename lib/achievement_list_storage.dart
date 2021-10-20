import 'package:shared_preferences/shared_preferences.dart';

class AchievementListStorage {

  final String _saveKey = "AchievementList";

  void save(List<String> achievementList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_saveKey, achievementList);
  }

  Future<List<String>> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_saveKey) ?? [];
  }
}
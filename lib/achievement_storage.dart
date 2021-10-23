import 'package:shared_preferences/shared_preferences.dart';
import 'achievement.dart';
import 'dart:convert';

class AchievementStorage {
  final String _saveKey = "Achievement";

  void save(List<Achievement> achievementList) async {
    var targetAchievementList =
        achievementList.map((f) => json.encode(f.toJson())).toList();
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_saveKey, targetAchievementList);
  }

  Future<List<Achievement>> load() async {
    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList(_saveKey) ?? [];
    var achievemenListFeature =
        result.map((f) => Achievement.fromJson(json.decode(f))).toList();
    return achievemenListFeature;
  }
}

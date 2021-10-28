import 'package:shared_preferences/shared_preferences.dart';
import 'achievement.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class AchievementStore {
  List<Achievement> _achievementList = [];
  final String _saveKey = "Achievement";

  static final AchievementStore _cache = AchievementStore._internal();

  // オブジェクトを常に作成するのではなく、もしキャッシュがあればそれを使う
  factory AchievementStore() {
    return _cache;
  }

  // コンストラクタをプライベートアクセスにしている
  AchievementStore._internal();

  int countAchievementList() {
    return _achievementList.length;
  }

  Achievement findByIndex(int index) {
    return _achievementList[index];
  }

  void addAchievement(String title, String detail, bool isImportant) {
    var date = _getFormattedDate();
    var id = countAchievementList() > 0 ? _achievementList.last.id + 1 : 1;
    var achievement = Achievement(id, title, detail, isImportant, date, date);
    _achievementList.add(achievement);
    save();
  }

  void updateAchievement(Achievement achievement, String title, String detail, bool isImportant) {
    achievement.title = title;
    achievement.detail = detail;
    achievement.isImportant = isImportant;
    var date = _getFormattedDate();
    achievement.updateDate = date;
    save();
  }

  void removeAchievement(int index) {
    _achievementList.removeAt(index);
    save();
  }

  String _getFormattedDate() {
    var outputFormat = DateFormat('yyyy/MM/dd HH:mm');
    var dateTime = outputFormat.format(DateTime.now());
    return dateTime;
  }

  void save() async {
    var targetAchievementList = _achievementList.map((f) => json.encode(f.toJson())).toList();
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_saveKey, targetAchievementList);
  }

  void load() async {
    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList(_saveKey) ?? [];
    _achievementList = result.map((f) => Achievement.fromJson(json.decode(f))).toList();
  }
}

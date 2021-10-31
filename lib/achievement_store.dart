import 'package:shared_preferences/shared_preferences.dart';
import 'achievement.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class AchievementStore {
  List<Achievement> _achievementList = [];
  final String _saveKey = "Achievement";

  static final AchievementStore _instance = AchievementStore._internal();

  // クラス名に._xxxでプライベートコンストラクタとなる
  AchievementStore._internal();

  // ファクトリーコンストラクタ
  // インスタンスを生成しないコンストラクタのため、自分でインスタンスを生成する
  factory AchievementStore() {
    // オブジェクトを常に作成するのではなく、もしキャッシュがあればそれを使う
    return _instance;
  }

  int countAchievementList() {
    return _achievementList.length;
  }

  Achievement findByIndex(int index) {
    return _achievementList[index];
  }

  void addAchievement(bool isImportant, String title, String detail) {
    var date = _getFormattedDate();
    var id = countAchievementList() > 0 ? _achievementList.last.id + 1 : 1;
    var achievement = Achievement(id, title, detail, isImportant, date, date);
    _achievementList.add(achievement);
    save();
  }

  void updateAchievement(Achievement achievement, bool isImportant, [String? title, String? detail]) {
    if (title != null) {
      achievement.title = title;
    }
    if (detail != null) {
      achievement.detail = detail;
    }

    achievement.isImportant = isImportant;
    var date = _getFormattedDate();
    achievement.updateDate = date;
    save();
  }

  void removeAchievement(Achievement achievement) {
    _achievementList.remove(achievement);
    save();
  }

  String _getFormattedDate() {
    var outputFormat = DateFormat('yyyy/MM/dd HH:mm');
    var dateTime = outputFormat.format(DateTime.now());
    return dateTime;
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    // AchievementList形式 → Map形式 → JSON形式 → StrigList形式
    var saveTargetAchievementList = _achievementList.map((a) => json.encode(a.toJson())).toList();
    prefs.setStringList(_saveKey, saveTargetAchievementList);
  }

  void load() async {
    var prefs = await SharedPreferences.getInstance();
    // StrigList形式 → JSON形式 → Map形式 → AchievementList形式
    var loadTargetAchievementList = prefs.getStringList(_saveKey) ?? [];
    _achievementList = loadTargetAchievementList.map((a) => Achievement.fromJson(json.decode(a))).toList();
  }
}

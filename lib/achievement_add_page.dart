import 'package:flutter/material.dart';
import 'achievement.dart';

class AchievementAddPage extends StatefulWidget {
  final Achievement? targetAchievement;
  const AchievementAddPage({Key? key, this.targetAchievement}) : super(key: key);

  @override
  _AchievementAddPageState createState() => _AchievementAddPageState();
}

class _AchievementAddPageState extends State<AchievementAddPage> {

  late Achievement? _achievement;
  late String _title;
  late String _detail; 
  late String _caption;

  Achievement createAchievement(String title, String detail) {
    return Achievement(title, detail, DateTime.now());
  }

  void updateAchievement(Achievement achievement, String title, String detail) {
    achievement.title = title;
    achievement.detail = detail;
  }

  @override
  void initState() {
    super.initState();
    _achievement = widget.targetAchievement;
    _title = _achievement?.title ?? "";
    _detail = _achievement?.detail ?? "";
    _caption = _achievement != null ? "編集" : "追加";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("できたこと$_caption"),
      ),
      body: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: TextEditingController(text: _title),
              onChanged: (String value) {
                _title = value;
              },
            ),
            TextField(
              controller: TextEditingController(text: _detail),
              onChanged: (String value) {
                _detail = value;
              },
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              // リスト追加・編集ボタン
              child: ElevatedButton(
                onPressed: () {
                  if (_achievement != null) {
                    updateAchievement(_achievement!, _title, _detail);
                  } else {
                    _achievement = createAchievement(_title, _detail);
                  }
                  Navigator.of(context).pop(_achievement);
                },
                child: Text(_caption, style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              // キャンセルボタン
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: const Text('キャンセル', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'achievement.dart';
import 'package:intl/intl.dart';

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
  late bool _isImportant;
  late String _createDate;
  late String _updateDate;

  Achievement createAchievement(String title, String detail, bool isImportant) {
    var date = getFormattedDate();
    return Achievement(title, detail, isImportant, date, date);
  }

  void updateAchievement(Achievement achievement, String title, String detail, bool isImportant) {
    achievement.title = title;
    achievement.detail = detail;
    achievement.isImportant = isImportant;
    var date = getFormattedDate();
    achievement.updateDate = date;
  }

  String getFormattedDate() {
    var outputFormat = DateFormat('yyyy/MM/dd HH:mm');
    var dateTime = outputFormat.format(DateTime.now());
    return dateTime;
  }

  @override
  void initState() {
    super.initState();
    _achievement = widget.targetAchievement;
    _title = _achievement?.title ?? "";
    _detail = _achievement?.detail ?? "";
    _caption = _achievement != null ? "更新" : "追加";
    _isImportant = _achievement?.isImportant ?? false;
    _createDate = _achievement?.createDate ?? "-";
    _updateDate = _achievement?.updateDate ?? "-";
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("作成日：$_createDate", textAlign: TextAlign.left),
            Text("更新日：$_updateDate", textAlign: TextAlign.left),
            CheckboxListTile(
              title: const Text("重要度", textAlign: TextAlign.left),
              value: _isImportant,
              onChanged: (bool? value) {
                setState(() {
                  _isImportant = value ?? false;
                });
              },
            ),
            const Text("タイトル", textAlign: TextAlign.left),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: TextEditingController(text: _title),
              onChanged: (String value) {
                _title = value;
              },
            ),
            const Text("詳細"),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 3,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: TextEditingController(text: _detail),
              onChanged: (String value) {
                _detail = value;
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              // リスト追加・編集ボタン
              child: ElevatedButton(
                onPressed: () {
                  if (_achievement != null) {
                    updateAchievement(_achievement!, _title, _detail, _isImportant);
                  } else {
                    _achievement = createAchievement(_title, _detail, _isImportant);
                  }
                  Navigator.of(context).pop(_achievement);
                },
                child: Text(_caption, style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
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

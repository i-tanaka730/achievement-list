import 'package:flutter/material.dart';

class AchievementAddPage extends StatefulWidget {
  final String? targetAchievement;
  const AchievementAddPage({Key? key, this.targetAchievement}) : super(key: key);

  @override
  _AchievementAddPageState createState() => _AchievementAddPageState();
}

class _AchievementAddPageState extends State<AchievementAddPage> {

  late String _achievement;
  late String _caption;

  @override
  void initState() {
    super.initState();
    _achievement = widget.targetAchievement ?? "";
    _caption = widget.targetAchievement != null ? "編集" : "追加";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("できたこと$_caption"),
      ),
      body: Container(
        // 余白を付ける
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: TextEditingController(text: _achievement),
              onChanged: (String value) {
                _achievement = value;
              },
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
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
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
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

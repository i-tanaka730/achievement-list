import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AchievementAddPage.dart';

/**
 * できたことリスト画面。
 */
class AchievementListPage extends StatefulWidget {
  @override
  _AchievementListPageState createState() => _AchievementListPageState();
}

/**
 * できたことリスト画面の状態。
 */
class _AchievementListPageState extends State<AchievementListPage> {
  // できたことリストのデータ
  List<String> _todoList = [];
  // 保存時のキー
  final String _saveKey = "AchievementList";

  // 追加
  void addAchievement() async {
    var achievement = await createAchievement();

    setState(() {
      _todoList.add(achievement);
    });

    saveAchievementList();
  }

  // 更新
  void updateAchievement(int index) async {
    var achievement = await createAchievement(_todoList[index]);

    setState(() {
      _todoList[index] = achievement;
    });

    saveAchievementList();
  }

  // 削除
  void removeAchievement(int index) {
    setState(() {
      _todoList.removeAt(index);
    });

    saveAchievementList();
  }

  // 保存
  void saveAchievementList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_saveKey, _todoList);
  }

  // 読込
  void loadAchievementList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoList = prefs.getStringList(_saveKey) ?? [];
    });
  }

  Future<String> createAchievement([String? targetAchievement]) async {
    String achievement = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AchievementAddPage(targetAchievement);
      }),
    );

    return achievement;
  }

  @override
  void initState() {
    super.initState();
    loadAchievementList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "できたことリスト",
        ),
      ),

      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return Slidable(
              actionExtentRatio: 0.2,
              actionPane: SlidableScrollActionPane(),
              actions: [
                IconSlideAction(
                  caption: '編集',
                  color: Colors.yellow,
                  icon: Icons.edit,
                  onTap: () {
                    updateAchievement(index);
                  },
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  caption: '削除',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    removeAchievement(index);
                  },
                )
              ],
              child: Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey))),
                  child: ListTile(
                    title: Text(_todoList[index]),
                  )));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addAchievement();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

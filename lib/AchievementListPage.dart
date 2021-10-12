import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  List<String> _todoList = ["test1", "test2"];

  // できたこと追加画面に遷移し、入力された値をリストに追加する
  void addAchievement() async {

    String? achievement = await createAchievement(null);
    if (achievement == null) {
      return;
    }

    setState(() {
      _todoList.add(achievement);
    });
  }

  void updateAchievement(int index) async {
    var achievement = await createAchievement(_todoList[index]);
    if (achievement == null) {
      return;
    }

    setState(() {
      _todoList[index] = achievement;
    });
  }

  Future<String> createAchievement(String? targetAchievement) async
  {
    String achievement = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AchievementAddPage(targetAchievement);
      }),
    );

    return achievement;
  }

  // ウィジェット構築
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "リスト一覧",
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
                    setState(() {
                      _todoList.removeAt(index);
                    });
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
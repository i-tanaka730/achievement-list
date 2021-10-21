import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'achievement_add_page.dart';
import 'achievement_storage.dart';
import 'achievement.dart';

class AchievementListPage extends StatefulWidget {

  const AchievementListPage({Key? key}) : super(key: key);

  @override
  _AchievementListPageState createState() => _AchievementListPageState();
}

class _AchievementListPageState extends State<AchievementListPage> {

  List<Achievement> _achievementList = [];
  final AchievementStorage _storage = AchievementStorage();

  // 追加
  void addAchievement() async {
    var achievement = await createAchievement();

    setState(() {
      _achievementList.add(achievement);
    });

    _storage.save(_achievementList);
  }

  // 更新
  void updateAchievement(int index) async {
    var achievement = await createAchievement(_achievementList[index]);

    setState(() {
      _achievementList[index] = achievement;
    });

    _storage.save(_achievementList);
  }

  // 削除
  void removeAchievement(int index) {
    setState(() {
      _achievementList.removeAt(index);
    });

    _storage.save(_achievementList);
  }

  Future<Achievement> createAchievement([Achievement? targetAchievement]) async {
    Achievement achievement = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AchievementAddPage(targetAchievement:targetAchievement);
      }),
    );

    return achievement;
  }

  @override
  void initState() {
    super.initState();

    loadAchievementList();
  }

  void loadAchievementList() async {
    _achievementList = await _storage.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "できたことリスト",
        ),
      ),

      body: ListView.builder(
        itemCount: _achievementList.length,
        itemBuilder: (context, index) {
          return Slidable(
              actionExtentRatio: 0.2,
              actionPane: const SlidableScrollActionPane(),
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
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey)
                  )
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    Text(_achievementList[index].createDate.toString()),
                    Expanded(
                      child:ListTile(
                        title: Text(_achievementList[index].title),
                      ),
                    )
                  ], // 子ウィジェット
                )
              )
            );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addAchievement();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

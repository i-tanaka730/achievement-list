import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'achievement_input_page.dart';
import 'achievement_store.dart';
import 'achievement.dart';

class AchievementListPage extends StatefulWidget {
  const AchievementListPage({Key? key}) : super(key: key);

  @override
  _AchievementListPageState createState() => _AchievementListPageState();
}

class _AchievementListPageState extends State<AchievementListPage> {
  final AchievementStore _store = AchievementStore();

  void pushAchievementInputPage([Achievement? targetAchievement]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AchievementInputPage(targetAchievement: targetAchievement);
      }),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future(() async {
      setState(() {
        _store.load();
      });
    });
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
        itemCount: _store.countAchievementList(),
        itemBuilder: (context, index) {
          var achievement = _store.findByIndex(index);
          return Slidable(
              actionPane: const SlidableScrollActionPane(),
              actions: [
                IconSlideAction(
                  caption: '編集',
                  color: Colors.yellow,
                  icon: Icons.edit,
                  onTap: () {
                    pushAchievementInputPage(achievement);
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
                      _store.removeAchievement(achievement);
                    });
                  },
                )
              ],
              child: Container(
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                child: ListTile(
                  leading: Text(achievement.id.toString()),
                  title: Text(achievement.title),
                  trailing: Checkbox(
                    value: achievement.isImportant,
                    onChanged: (bool? value) {
                      setState(() {
                        AchievementStore().updateAchievement(achievement, value ?? false);
                      });
                    },
                  ),
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushAchievementInputPage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

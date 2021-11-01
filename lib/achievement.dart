class Achievement {
  late int id;
  late String title;
  late String detail;
  late bool isImportant;
  late String createDate;
  late String updateDate;

  Achievement(this.id, this.title, this.detail, this.isImportant, this.createDate, this.updateDate);

  Map toJson() {
    return {'id': id, 'title': title, 'detail': detail, 'isImportant': isImportant, 'createDate': createDate, 'updateDate': updateDate};
  }

  // 名前付きコンストラクタ
  Achievement.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    isImportant = json['isImportant'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }
}

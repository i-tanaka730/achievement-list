class Achievement {
  late String title;
  late String detail;
  late bool isImportant;
  late String createDate;
  late String updateDate;

  Achievement(this.title, this.detail, this.isImportant, this.createDate,
      this.updateDate);

  Map toJson() {
    return {
      'title': title,
      'detail': detail,
      'isImportant': isImportant,
      'createDate': createDate,
      'updateDate': updateDate
    };
  }

  Achievement.fromJson(Map json) {
    title = json['title'];
    detail = json['detail'];
    isImportant = json['isImportant'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }
}

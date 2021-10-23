class Achievement {
  late String title;
  late String detail;
  late String createDate;
  late String updateDate;

  Achievement(this.title, this.detail, this.createDate, this.updateDate);

  Map toJson() {
    return {
      'title': title,
      'detail': detail,
      'createDate': createDate,
      'updateDate': updateDate
    };
  }

  Achievement.fromJson(Map json) {
    title = json['title'];
    detail = json['detail'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }
}

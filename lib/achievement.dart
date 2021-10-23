class Achievement {
  late String title;
  late String detail;
  late String createDate;

  Achievement(this.title, this.detail, this.createDate);

  Map toJson() {
    return {'title': title, 'detail': detail, 'createDate': createDate};
  }

  Achievement.fromJson(Map json) {
    title = json['title'];
    detail = json['detail'];
    createDate = json['createDate'];
  }
}

class NoticeObject {
  String desc;
  String title;
  DateTime publishedDate;
  List<Map<String, dynamic>> fileList;

  NoticeObject({this.fileList});

  static NoticeObject convertDocToObject() {}
}

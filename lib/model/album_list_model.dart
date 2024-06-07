class AlbumListModel {
  int? userId;
  int? id;
  String? title;

  AlbumListModel({this.userId, this.id, this.title});
  factory AlbumListModel.fromJson(Map<String, dynamic> json) {
    return AlbumListModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

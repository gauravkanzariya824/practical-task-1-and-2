class EditAlbumDetails {
  int? userId;
  int? id;
  String? title;

  EditAlbumDetails({this.userId, this.id, this.title});
  factory EditAlbumDetails.fromJson(Map<String, dynamic> json) {
    return EditAlbumDetails(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class NoteModel {
  final int? id;
  final String title;
  final String content;
  NoteModel({
    this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> updateNote() => <String, dynamic>{
        'id': id,
        'title': title,
        'content': content,
      };
  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'content': content,
      };
}

class NoteResponseModel {
  final int status;
  final String message;
  final NoteResponseData? data;

  NoteResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory NoteResponseModel.fromJson(Map<String, dynamic> json) =>
      NoteResponseModel(
        status: json["status"],
        message: json["message"],
        data: NoteResponseData.fromJson(json["data"]),
      );
  factory NoteResponseModel.fromJsonNoData(Map<String, dynamic> json) =>
      NoteResponseModel(status: json["status"], message: json["message"]);
}

class NoteResponseData {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteResponseData({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory NoteResponseData.fromJson(Map<String, dynamic> json) =>
      NoteResponseData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}

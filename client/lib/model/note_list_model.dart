class NoteListResponseModel {
  final int status;
  final String message;
  final List<NoteListResponseData> data;

  NoteListResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NoteListResponseModel.fromJson(Map<String, dynamic> json) =>
      NoteListResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<NoteListResponseData>.from(
            json["data"].map((x) => NoteListResponseData.fromJson(x))),
      );
}

class NoteListResponseData {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteListResponseData({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory NoteListResponseData.fromJson(Map<String, dynamic> json) =>
      NoteListResponseData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}

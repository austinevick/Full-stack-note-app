import 'dart:convert';

import 'package:client/model/note_list_model.dart';
import 'package:client/model/note_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class NoteRemoteRepository {
  final _client = Client();
  final _baseUrl = "http://127.0.0.1:3000/api/v1/";
  Map<String, String> customHeader = {
    'content-type': 'application/json; charset=UTF-8'
  };
  Future<NoteResponseModel> createNotes(NoteModel model) async {
    final response = await _client.post(Uri.parse("${_baseUrl}notes"),
        headers: customHeader, body: jsonEncode(model.toMap()));
    final data = jsonDecode(response.body);

    return NoteResponseModel.fromJson(data);
  }

  Future<List<NoteListResponseData>> getNotes() async {
    final response = await _client.get(Uri.parse("${_baseUrl}notes"));
    final data = jsonDecode(response.body);
    await GetStorage().write('note', data);
    return NoteListResponseModel.fromJson(data).data;
  }

  Future<List<NoteListResponseData>> getNotesFromDisk() async {
    final response = await GetStorage().read('note');
    return NoteListResponseModel.fromJson(response).data;
  }

  Future<NoteResponseModel> updateNotes(NoteModel model) async {
    final response = await _client.put(
        Uri.parse("${_baseUrl}notes/${model.id}"),
        headers: customHeader,
        body: jsonEncode(model.updateNote()));
    final data = jsonDecode(response.body);
    return NoteResponseModel.fromJson(data);
  }

  Future<int> deleteNotes(int id) async {
    final response = await _client.delete(Uri.parse("${_baseUrl}notes/$id"),
        headers: customHeader);
    return response.statusCode;
  }
}

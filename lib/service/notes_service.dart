import 'dart:convert';
import 'dart:io';

import 'package:notesave/constants/constants.dart';
import 'package:notesave/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:notesave/response_model/api_response.dart';

class NotesService {
  Future<ApiResponse> getAllNotesList() async {
    var apiResponse = ApiResponse<dynamic>(null);
    Uri url = Uri.parse('${Constants.BaseURL}/${Constants.BaseEndpoint}');
    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      switch (response.statusCode) {
        case 200:
          apiResponse.responseData = List<Note>.from(
              json.decode(response.body).map((i) => Note.fromJson(i)));
          break;
        case 401:
          apiResponse.responseData = json.decode(response.body);
          break;
        default:
          apiResponse.responseData = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.responseData = "Server error. Please retry";
    }
    return apiResponse;
  }

  Future<ApiResponse> postNote(Note note) async {
    var apiResponse = ApiResponse<dynamic>(null);
    Uri url = Uri.parse('${Constants.BaseURL}/${Constants.BaseEndpoint}');

    try {
      var body = json.encode(note);
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      switch (response.statusCode) {
        case 200:
          apiResponse.responseData = Note.fromJson(json.decode(response.body));
          break;
        case 401:
          apiResponse.responseData = json.decode(response.body);
          break;
        default:
          apiResponse.responseData = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.responseData = "Server error. Please retry";
    }
    return apiResponse;
  }

  Future<ApiResponse> deleteNote(int id) async {
    var apiResponse = ApiResponse<dynamic>(null);
    Uri url = Uri.parse('${Constants.BaseURL}/${Constants.BaseEndpoint}/$id');

    try {
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.responseData = Note.fromJson(json.decode(response.body));
          break;
        case 401:
          apiResponse.responseData = json.decode(response.body);
          break;
        default:
          apiResponse.responseData = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.responseData = "Server error. Please retry";
    }
    return apiResponse;
  }

  Future<ApiResponse> patchNote(Note note) async {
    var apiResponse = ApiResponse<dynamic>(null);
    Uri url =
        Uri.parse('${Constants.BaseURL}/${Constants.BaseEndpoint}/${note.id!}');

    try {
      var body = json.encode(note);
      final response = await http.patch(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      switch (response.statusCode) {
        case 200:
          apiResponse.responseData = Note.fromJson(json.decode(response.body));
          break;
        case 401:
          apiResponse.responseData = json.decode(response.body);
          break;
        default:
          apiResponse.responseData = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.responseData = "Server error. Please retry";
    }
    return apiResponse;
  }
}

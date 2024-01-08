import 'dart:convert';
import 'dart:io';
import 'package:notesave/cache/shared_preferences_service.dart';
import 'package:notesave/constants/constants.dart';
import 'package:notesave/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:notesave/response_model/api_response.dart';

class NotesService {
  Future<ApiResponse> getAllNotesList() async {
    var apiResponse = ApiResponse<dynamic>(null);
    Uri url = Uri.parse('${Constants.BaseURL}/${Constants.BaseEndpoint}');
    try {
      SharedPreferencesService sharedPreferencesService =
          SharedPreferencesService();
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      switch (response.statusCode) {
        case 200:
          apiResponse.data = List<Note>.from(
              json.decode(response.body).map((i) => Note.fromJson(i)));
          sharedPreferencesService.saveDataWithExpiration(
              response.body, const Duration(days: 7));
          break;
        case 401:
          apiResponse.data = json.decode(response.body);
          break;
        default:
          apiResponse.data = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.data = "Server error. Please retry";
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
          final encoded = jsonEncode(response.body);
          final decoded = jsonDecode(encoded);
          apiResponse.data = Note.fromJson(decoded);

          break;
        case 401:
          apiResponse.data = json.decode(response.body);
          break;
        default:
          apiResponse.data = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.data = "Server error. Please retry";
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
          final decoded = jsonDecode(response.body);
          apiResponse.data = Note.fromJson(decoded);
          break;
        case 401:
          apiResponse.data = json.decode(response.body);
          break;
        default:
          apiResponse.data = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.data = "Server error. Please retry";
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
          final decoded = jsonDecode(response.body);
          apiResponse.data = Note.fromJson(decoded);
          break;
        case 401:
          apiResponse.data = json.decode(response.body);
          break;
        default:
          apiResponse.data = json.decode(response.body);
          break;
      }
    } on SocketException {
      apiResponse.data = "Server error. Please retry";
    }
    return apiResponse;
  }
}

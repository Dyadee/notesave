import 'dart:convert';
import 'dart:io';

import 'package:notesave/constants/constants.dart';
import 'package:notesave/models/note.dart';
import 'package:http/http.dart' as http;

class NotesService {
  // Future<List<Note>> getAllNotesList() async {
  Future<List<Note>> getAllNotesList() async {
    Uri url = Uri.parse('${Constants.BaseURL}/${Constants.BaseEndpoint}');
    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      // switch (response.statusCode) {
      //   case 200:
      //     apiResponse.responseData = List<Car>.from(
      //         json.decode(response.body)['cars'].map((i) => Car.fromJson(i)));

      //     break;
      //   case 401:
      //     apiResponse.responseData =
      //         ApiError.fromJson(json.decode(response.body));
      //     break;
      //   default:
      //     apiResponse.responseData =
      //         ApiError.fromJson(json.decode(response.body));
      //     break;
      // }
      print('${response.statusCode}: ${response.body}');
      // return Note.fromJson(json) jsonDecode(response.body);
    } on SocketException {
      // apiResponse.responseData = ApiError(error: "Server error. Please retry");
    }
    // return apiResponse;
    return [];
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notesave/helpers/string_int_converter.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    String? title,
    String? description,
    @IntStringConverter() int? id,
  }) = _Note;

  factory Note.fromJson(Map<String, Object?> json) => _$NoteFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
      title: json['title'] as String?,
      description: json['description'] as String?,
      id: const IntStringConverter().fromJson(json['id'] as String?),
    );

Map<String, dynamic> _$$NoteImplToJson(_$NoteImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'id': const IntStringConverter().toJson(instance.id),
    };

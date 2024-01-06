import 'package:json_annotation/json_annotation.dart';

class IntStringConverter implements JsonConverter<int?, String?> {
  const IntStringConverter();
  @override
  String? toJson(int? _) {
    final result = _ != null ? _.toString() : '0';
    return result;
  }

  @override
  int? fromJson(String? _) {
    final result = _ != null ? int.parse(_) : 0;
    return result;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
    json['task'] as String,
    complete: json['complete'] as bool,
    note: json['note'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'complete': instance.complete,
      'id': instance.id,
      'note': instance.note,
      'task': instance.task,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoState _$TodoStateFromJson(Map<String, dynamic> json) {
  return TodoState(
    json['remoteTodo'] == null
        ? null
        : Todo.fromJson(json['remoteTodo'] as Map<String, dynamic>),
    json['todo'] == null
        ? null
        : Todo.fromJson(json['todo'] as Map<String, dynamic>),
    invalidated: json['invalidated'] as bool,
  );
}

Map<String, dynamic> _$TodoStateToJson(TodoState instance) => <String, dynamic>{
      'remoteTodo': instance.remoteTodo?.toJson(),
      'todo': instance.todo?.toJson(),
      'invalidated': instance.invalidated,
    };

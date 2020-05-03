// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoState _$TodoStateFromJson(Map<String, dynamic> json) {
  return TodoState(
    json['todo'] == null
        ? null
        : Todo.fromJson(json['todo'] as Map<String, dynamic>),
    dirty: json['dirty'] as bool,
  );
}

Map<String, dynamic> _$TodoStateToJson(TodoState instance) => <String, dynamic>{
      'todo': instance.todo?.toJson(),
      'dirty': instance.dirty,
    };

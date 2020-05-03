import 'package:json_annotation/json_annotation.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  Todo(
    this.task, {
    this.complete = false,
    String note = '',
    String id,
  })  : note = note ?? '',
        id = id ?? Uuid().generateV4();

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  final bool complete;
  final String id;
  final String note;
  final String task;

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWith({bool complete, String id, String note, String task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  TodoEntity toEntity() => TodoEntity(task, id, note, complete);

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4(),
    );
  }

  @override
  List<Object> get props => [complete, id, note, task];

  @override
  bool get stringify => true;
}

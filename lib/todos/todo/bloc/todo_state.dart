part of 'todo_bloc.dart';

@JsonSerializable(explicitToJson: true)
class TodoState extends Equatable {
  const TodoState(this.remoteTodo, this.todo, {this.invalidated = false});

  factory TodoState.fromJson(Map<String, dynamic> json) =>
      _$TodoStateFromJson(json);

  final Todo remoteTodo;
  final Todo todo;
  bool get dirty => todo != remoteTodo;
  final bool invalidated;

  Map<String, dynamic> toJson() => _$TodoStateToJson(this);

  @override
  List<Object> get props => [remoteTodo, todo, invalidated];

  @override
  bool get stringify => true;
}

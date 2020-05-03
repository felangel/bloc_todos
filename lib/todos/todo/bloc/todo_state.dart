part of 'todo_bloc.dart';

@JsonSerializable(explicitToJson: true)
class TodoState extends Equatable {
  const TodoState(this.todo, {this.dirty = false, this.invalidated = false});

  factory TodoState.fromJson(Map<String, dynamic> json) =>
      _$TodoStateFromJson(json);

  final Todo todo;
  final bool dirty;
  final bool invalidated;

  Map<String, dynamic> toJson() => _$TodoStateToJson(this);

  @override
  List<Object> get props => [todo, dirty, invalidated];

  @override
  bool get stringify => true;
}

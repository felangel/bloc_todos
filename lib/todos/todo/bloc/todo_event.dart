part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class TodoTaskChanged extends TodoEvent {
  const TodoTaskChanged(this.task);

  final String task;

  @override
  List<Object> get props => [task];
}

class TodoSaved extends TodoEvent {}

class TodoUpdated extends TodoEvent {
  TodoUpdated(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

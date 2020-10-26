part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class TodosRequested extends TodosEvent {
  const TodosRequested();
}

class TodoAdded extends TodosEvent {
  const TodoAdded(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodoDeleted extends TodosEvent {
  const TodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodoSelected extends TodosEvent {
  const TodoSelected(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodoSavedUpstream extends TodosEvent {
  const TodoSavedUpstream(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodoToggled extends TodosEvent {
  const TodoToggled(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}

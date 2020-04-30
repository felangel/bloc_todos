part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class TodosLoadInProgress extends TodosState {}

class TodosLoadSuccess extends TodosState {
  const TodosLoadSuccess({this.todos = const <Todo>[], this.activeTodo});

  final List<Todo> todos;
  final Todo activeTodo;

  TodosLoadSuccess copyWith({
    List<Todo> todos,
    Todo activeTodo,
  }) {
    return TodosLoadSuccess(
      todos: todos ?? this.todos,
      activeTodo: activeTodo ?? this.activeTodo,
    );
  }

  @override
  List<Object> get props => [todos, activeTodo];
}

class TodosLoadFailure extends TodosState {}

part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class TodosChanged extends FilteredTodosEvent {
  const TodosChanged(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

class FilterChanged extends FilteredTodosEvent {
  const FilterChanged(this.filter);

  final VisibilityFilter filter;

  @override
  List<Object> get props => [filter];
}

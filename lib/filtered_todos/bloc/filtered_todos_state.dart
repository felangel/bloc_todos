part of 'filtered_todos_bloc.dart';

class FilteredTodosState extends Equatable {
  const FilteredTodosState({
    this.todos = const <Todo>[],
    this.filteredTodos = const <Todo>[],
    this.filter = VisibilityFilter.all,
  });

  final List<Todo> todos;
  final List<Todo> filteredTodos;
  final VisibilityFilter filter;

  @override
  List<Object> get props => [todos, filteredTodos, filter];

  @override
  bool get stringify => true;
}

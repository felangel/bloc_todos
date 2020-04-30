import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todos/filtered_todos/filtered_todos.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  FilteredTodosBloc({@required Stream<TodosState> todos})
      : assert(todos != null) {
    _subscription = todos.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosChanged(state.todos));
      }
    });
  }

  StreamSubscription<TodosState> _subscription;

  @override
  FilteredTodosState get initialState => const FilteredTodosState();

  @override
  Stream<FilteredTodosState> mapEventToState(
    FilteredTodosEvent event,
  ) async* {
    if (event is TodosChanged) {
      yield* _mapTodosChangedToState(event, state);
    } else if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event, state);
    }
  }

  Stream<FilteredTodosState> _mapTodosChangedToState(
    TodosChanged event,
    FilteredTodosState state,
  ) async* {
    final visibilityFilter = state.filter ?? VisibilityFilter.all;
    yield FilteredTodosState(
      todos: event.todos,
      filteredTodos: _mapTodosToFilteredTodos(event.todos, visibilityFilter),
      filter: visibilityFilter,
    );
  }

  Stream<FilteredTodosState> _mapFilterChangedToState(
    FilterChanged event,
    FilteredTodosState state,
  ) async* {
    final todos = List<Todo>.from(state.todos);
    yield FilteredTodosState(
      todos: todos,
      filteredTodos: _mapTodosToFilteredTodos(todos, event.filter),
      filter: event.filter,
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
    List<Todo> todos,
    VisibilityFilter filter,
  ) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

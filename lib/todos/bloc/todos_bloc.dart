import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todos/todos/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({@required TodosRepository todosRepository})
      : assert(todosRepository != null),
        _todosRepository = todosRepository;

  final TodosRepository _todosRepository;

  @override
  TodosState get initialState => TodosLoadInProgress();

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is TodosRequested) {
      yield* _mapTodosRequestedToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event, state);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event, state);
    } else if (event is TaskUpdated) {
      yield* _mapTaskUpdatedToState(event, state);
    } else if (event is TodoSelected) {
      yield* _mapTodoSelectedToState(event, state);
    } else if (event is TodoToggled) {
      yield* _mapTodoToggledToState(event, state);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState(state);
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState(state);
    }
  }

  Stream<TodosState> _mapTodosRequestedToState() async* {
    yield TodosLoadInProgress();
    try {
      final todos = await _todosRepository.loadTodos();
      yield TodosLoadSuccess(
        todos: todos.map(Todo.fromEntity).toList(),
      );
    } on Exception catch (_) {
      yield TodosLoadFailure();
    }
  }

  Stream<TodosState> _mapTodoAddedToState(
    TodoAdded event,
    TodosState state,
  ) async* {
    if (state is TodosLoadSuccess) {
      final updatedTodos = List<Todo>.from(state.todos)..add(event.todo);
      await _saveTodos(updatedTodos);
      yield TodosLoadSuccess(todos: updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(
    TodoDeleted event,
    TodosState state,
  ) async* {
    if (state is TodosLoadSuccess) {
      final updatedTodos =
          state.todos.where((todo) => todo.id != event.todo.id).toList();
      await _saveTodos(updatedTodos);
      yield TodosLoadSuccess(todos: updatedTodos);
    }
  }

  Stream<TodosState> _mapTaskUpdatedToState(
    TaskUpdated event,
    TodosState state,
  ) async* {
    if (state is TodosLoadSuccess && state.activeTodo != null) {
      final updatedTodos = state.todos
          .map((todo) => todo.id == state.activeTodo.id
              ? todo.copyWith(task: event.task)
              : todo)
          .toList();
      await _saveTodos(updatedTodos);
      yield state.copyWith(
        todos: updatedTodos,
        activeTodo: state.activeTodo.copyWith(task: event.task),
      );
    }
  }

  Stream<TodosState> _mapTodoSelectedToState(
    TodoSelected event,
    TodosState state,
  ) async* {
    if (state is TodosLoadSuccess) {
      yield TodosLoadSuccess(
        todos: List.from(state.todos),
        activeTodo: event.todo,
      );
    }
  }

  Stream<TodosState> _mapTodoToggledToState(
    TodoToggled event,
    TodosState state,
  ) async* {
    if (state is TodosLoadSuccess && state.activeTodo != null) {
      final updatedTodos = state.todos
          .map((todo) => todo.id == state.activeTodo.id
              ? todo.copyWith(complete: !todo.complete)
              : todo)
          .toList();
      await _saveTodos(updatedTodos);
      yield state.copyWith(
        todos: updatedTodos,
        activeTodo: state.activeTodo.copyWith(
          complete: !state.activeTodo.complete,
        ),
      );
    }
  }

  Stream<TodosState> _mapToggleAllToState(TodosState state) async* {
    if (state is TodosLoadSuccess) {
      final allComplete = state.todos.every((todo) => todo.complete);
      final updatedTodos = state.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      await _saveTodos(updatedTodos);
      yield TodosLoadSuccess(todos: updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState(TodosState state) async* {
    if (state is TodosLoadSuccess) {
      final updatedTodos = state.todos.where((todo) => !todo.complete).toList();
      await _saveTodos(updatedTodos);
      yield TodosLoadSuccess(todos: updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return _todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}

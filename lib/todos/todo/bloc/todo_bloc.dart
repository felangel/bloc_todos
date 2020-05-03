import 'dart:async';

import 'package:bloc_todos/todos/todos.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'todo_bloc.g.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc({@required Todo todo, @required TodosBloc todosBloc})
      : assert(todo != null),
        assert(todosBloc != null),
        _todo = todo,
        _todosBloc = todosBloc {
    _subscription = todosBloc.listen((state) {
      if (state is TodosLoadSuccess) {
        final todo = state.todos.firstWhere(
          (element) => element.id == _todo.id,
          orElse: () => null,
        );
        if (todo != null) {
          add(TodoUpdated(todo));
        }
      }
    });
  }

  StreamSubscription<TodosState> _subscription;
  final Todo _todo;
  final TodosBloc _todosBloc;

  @override
  String get id => _todo.id;

  @override
  TodoState get initialState {
    final cachedState = super.initialState;
    return cachedState != null
        ? TodoState(_merge(_todo, cachedState.todo, cachedState.invalidated))
        : TodoState(_todo);
  }

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is TodoTaskChanged) {
      yield _mapTodoTaskChangedToState(event, state);
    } else if (event is TodoSaved) {
      _todosBloc.add(TaskUpdated(state.todo.task));
      yield TodoState(state.todo, invalidated: true);
    } else if (event is TodoUpdated) {
      yield TodoState(
        _merge(event.todo, state.todo, state.invalidated),
        dirty: event.todo.task != state.todo.task,
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  TodoState _mapTodoTaskChangedToState(TodoTaskChanged event, TodoState state) {
    return TodoState(
      state.todo.copyWith(task: event.task),
      dirty: event.task != _todo.task,
    );
  }

  Todo _merge(Todo remote, Todo local, bool invalidated) {
    return invalidated ? remote : local.copyWith(complete: remote.complete);
  }

  @override
  TodoState fromJson(Map<String, dynamic> json) => TodoState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TodoState state) => state.toJson();
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({@required Stream<TodosState> todosState})
      : assert(todosState != null) {
    _subscription = todosState.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosChanged(state.todos));
      }
    });
  }

  StreamSubscription _subscription;

  @override
  StatsState get initialState => StatsLoadInProgress();

  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if (event is TodosChanged) {
      final activeTodos =
          event.todos.where((todo) => !todo.complete).toList().length;
      final completedTodos = event.todos.length - activeTodos;
      yield StatsLoadSuccess(
        activeTodos: activeTodos,
        completedTodos: completedTodos,
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

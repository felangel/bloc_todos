part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class TodosChanged extends StatsEvent {
  const TodosChanged(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

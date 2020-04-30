part of 'stats_bloc.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class StatsLoadInProgress extends StatsState {}

class StatsLoadSuccess extends StatsState {
  const StatsLoadSuccess({
    @required this.activeTodos,
    @required this.completedTodos,
  })  : assert(activeTodos != null),
        assert(completedTodos != null);

  final int activeTodos;
  final int completedTodos;

  @override
  List<Object> get props => [activeTodos, completedTodos];
}

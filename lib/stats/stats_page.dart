import 'package:bloc_todos/stats/stats.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsBloc(todosState: context.bloc<TodosBloc>()),
      child: const Stats(),
    );
  }
}

class Stats extends StatelessWidget {
  const Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoadInProgress) {
          return const _StatsLoadingIndicator();
        } else if (state is StatsLoadSuccess) {
          return _Stats(
            activeTodos: state.activeTodos,
            completedTodos: state.completedTodos,
          );
        } else {
          return const _StatsError();
        }
      },
    );
  }
}

class _StatsLoadingIndicator extends StatelessWidget {
  const _StatsLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _Stats extends StatelessWidget {
  const _Stats({
    Key key,
    @required this.activeTodos,
    @required this.completedTodos,
  })  : assert(activeTodos != null),
        assert(completedTodos != null),
        super(key: key);

  final int activeTodos;
  final int completedTodos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Completed Todos', style: theme.textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text('$completedTodos', style: theme.textTheme.subtitle1),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Active Todos', style: theme.textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text("$activeTodos", style: theme.textTheme.subtitle1),
          )
        ],
      ),
    );
  }
}

class _StatsError extends StatelessWidget {
  const _StatsError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Something went wrong.'));
  }
}

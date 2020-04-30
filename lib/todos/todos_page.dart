import 'package:bloc_todos/filtered_todos/filtered_todos.dart';
import 'package:bloc_todos/todos/bloc/todos_bloc.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadInProgress) {
          return const _TodosLoadingIndicator();
        } else if (state is TodosLoadSuccess) {
          return const FilteredTodosList();
        } else {
          return const _TodosError();
        }
      },
    );
  }
}

class _TodosLoadingIndicator extends StatelessWidget {
  const _TodosLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _TodosError extends StatelessWidget {
  const _TodosError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Something went wrong'));
  }
}

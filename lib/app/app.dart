import 'package:bloc_todos/home/home.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:todos_app_core/todos_app_core.dart';

class TodosApp extends StatelessWidget {
  const TodosApp({Key key, @required this.todosRepository})
      : assert(todosRepository != null),
        super(key: key);

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodosBloc(
        todosRepository: todosRepository,
      )..add(const TodosRequested()),
      child: MaterialApp(
        theme: ArchSampleTheme.theme,
        home: HomePage(),
      ),
    );
  }
}

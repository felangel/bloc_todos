import 'package:bloc_todos/app/app.dart';
import 'package:bloc_todos/todos_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = TodosBlocDelegate(
    await HydratedBlocStorage.getInstance(),
  );
  const todosRepository = TodosRepositoryFlutter(
    fileStorage: FileStorage(
      '__flutter_bloc_app__',
      getApplicationDocumentsDirectory,
    ),
  );
  runApp(const TodosApp(todosRepository: todosRepository));
}

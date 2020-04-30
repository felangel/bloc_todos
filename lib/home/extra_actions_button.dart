import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ExtraAction { toggleAllComplete, clearCompleted }

class ExtraActions extends StatelessWidget {
  const ExtraActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadSuccess) {
          final allComplete = state.todos.every((todo) => todo.complete);
          return PopupMenuButton<ExtraAction>(
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  context.bloc<TodosBloc>().add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  context.bloc<TodosBloc>().add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                value: ExtraAction.toggleAllComplete,
                child: Text(
                    allComplete ? 'Mark All Incomplete' : 'Mark All Complete'),
              ),
              const PopupMenuItem<ExtraAction>(
                value: ExtraAction.clearCompleted,
                child: Text('Clear Completed'),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

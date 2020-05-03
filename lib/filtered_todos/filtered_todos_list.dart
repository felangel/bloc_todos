import 'package:bloc_todos/filtered_todos/filtered_todos.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredTodosList extends StatelessWidget {
  const FilteredTodosList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.filteredTodos.length,
          itemBuilder: (context, index) {
            final todo = state.filteredTodos[index];
            return BlocProvider(
              create: (context) => TodoBloc(
                todo: todo,
                todosBloc: context.bloc<TodosBloc>(),
              ),
              child: TodoItem(
                key: Key('__todo_item_${todo.id}__'),
                todo: todo,
                onDismissed: (_) {
                  context.bloc<TodosBloc>().add(TodoDeleted(todo));
                  Scaffold.of(context).showSnackBar(
                    _DeleteTodoSnackBar(
                      todo: todo,
                      onUndo: () {
                        context.bloc<TodosBloc>().add(TodoAdded(todo));
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _DeleteTodoSnackBar extends SnackBar {
  _DeleteTodoSnackBar({
    Key key,
    @required Todo todo,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Deleted ${todo.task}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}

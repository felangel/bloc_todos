import 'package:bloc_todos/todos/models/models.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key key,
    @required this.todo,
    this.onDismissed,
  }) : super(key: key);

  final Todo todo;
  final DismissDirectionCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Dismissible(
          key: Key(state.todo.id),
          onDismissed: onDismissed,
          child: ListTile(
            leading: Checkbox(
              value: state.todo.complete,
              onChanged: (complete) {
                context.bloc<TodoBloc>().add(TodoCompleteChanged(complete));
              },
            ),
            title: TextFormField(
              initialValue: state.todo.task,
              onChanged: (task) {
                context.bloc<TodoBloc>().add(TodoTaskChanged(task));
              },
              onTap: () {
                context.bloc<TodosBloc>().add(TodoSelected(state.todo));
              },
              style: state.todo.complete
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
            trailing: Visibility(
              visible: state.dirty,
              child: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () => context.bloc<TodoBloc>().add(TodoSaved()),
              ),
            ),
          ),
        );
      },
    );
  }
}

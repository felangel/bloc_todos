import 'package:bloc_todos/todos/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key key,
    @required this.todo,
    this.onDismissed,
    this.onPressed,
    this.onChanged,
  }) : super(key: key);

  final Todo todo;
  final DismissDirectionCallback onDismissed;
  final VoidCallback onPressed;
  final ValueSetter<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      onDismissed: onDismissed,
      child: ListTile(
        title: TextFormField(
          initialValue: todo.task,
          onChanged: onChanged,
          onTap: onPressed?.call,
          style: todo.complete
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
      ),
    );
  }
}

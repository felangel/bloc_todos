import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoToggleButton extends StatelessWidget {
  const TodoToggleButton({Key key, @required this.visible})
      : assert(visible != null),
        super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadSuccess && state.activeTodo != null) {
          return AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 150),
            child: IconButton(
              icon: Icon(
                state.activeTodo.complete
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
              onPressed: () {
                context.bloc<TodosBloc>().add(TodoToggled(state.activeTodo));
              },
            ),
          );
        } else {
          return const IconButton(
            icon: Icon(Icons.indeterminate_check_box),
            onPressed: null,
          );
        }
      },
    );
  }
}

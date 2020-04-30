import 'package:bloc_todos/filtered_todos/filtered_todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoFilterButton extends StatelessWidget {
  const TodoFilterButton({Key key, this.visible}) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(color: Theme.of(context).accentColor);
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
        builder: (context, state) {
      final button = _Button(
        onSelected: (filter) {
          context.bloc<FilteredTodosBloc>().add(FilterChanged(filter));
        },
        activeFilter: state.filter,
        activeStyle: activeStyle,
        defaultStyle: defaultStyle,
      );
      return AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 150),
        child: visible ? button : IgnorePointer(child: button),
      );
    });
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  })  : assert(onSelected != null),
        assert(activeFilter != null),
        assert(activeStyle != null),
        assert(defaultStyle != null),
        super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      tooltip: 'Filter Todos',
      onSelected: onSelected,
      itemBuilder: (context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.all,
          child: Text(
            'Show All',
            style: activeFilter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.active,
          child: Text(
            'Show Active',
            style: activeFilter == VisibilityFilter.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.completed,
          child: Text(
            'Show Completed',
            style: activeFilter == VisibilityFilter.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: const Icon(Icons.filter_list),
    );
  }
}

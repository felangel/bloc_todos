import 'package:bloc_todos/add_todo/add_todo.dart';
import 'package:bloc_todos/filtered_todos/bloc/filtered_todos_bloc.dart';
import 'package:bloc_todos/home/home.dart';
import 'package:bloc_todos/stats/stats.dart';
import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(
          create: (context) => FilteredTodosBloc(
            todos: context.bloc<TodosBloc>(),
          ),
        ),
      ],
      child: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            final focusNode = FocusScope.of(context);
            if (!focusNode.hasPrimaryFocus) {
              focusNode.unfocus();
            }
            context.bloc<TodosBloc>().add(const TodoSelected(null));
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Todos'),
              actions: [
                TodoToggleButton(visible: state.activeTab == HomeTab.todos),
                TodoFilterButton(visible: state.activeTab == HomeTab.todos),
                const ExtraActions(),
              ],
            ),
            body: state.activeTab == HomeTab.stats
                ? const StatsPage()
                : const TodosPage(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).push(AddTodoPage.route()),
              child: const Icon(Icons.add),
              tooltip: 'Add Todo',
            ),
            bottomNavigationBar: BottomNavigation(
              activeTab: state.activeTab,
              onTabChanged: (index) {
                context.bloc<HomeBloc>().add(HomeTabChanged(index));
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:bloc_todos/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AddTodoPage._());
  }

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: '',
                style: textTheme.headline5,
                decoration: const InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: '',
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: const InputDecoration(
                  hintText: 'Additional notes...',
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            context.bloc<TodosBloc>().add(TodoAdded(Todo(_task, note: _note)));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

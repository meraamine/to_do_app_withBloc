import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/todo.dart';
import 'package:todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_event.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TodoBloc(),
        child: TodoScreen(),
      ),
    );
  }
}

class TodoScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(" Add Your Tasks Here :) ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black))),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Todo Title',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                todoBloc.add(AddTodoEvent(_textEditingController.text));
                _textEditingController.clear();
              },
              child: Text('Add Todo'),
            ),
            SizedBox(height: 20),
            BlocBuilder<TodoBloc, List<Todo>>(
              builder: (context, todos) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (_) {
                            todoBloc.add(ToggleTodoEvent(index));
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/todo.dart';
import 'package:todo_bloc/todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  TodoBloc() : super([]) {
    on<AddTodoEvent>((event, emit) {
      emit([
        ...state,
        Todo(
          title: event.title,
        )
      ]);
    });

    on<ToggleTodoEvent>((event, emit) {
      final updatedTodos = state.map((todo) {
        if (state.indexOf(todo) == event.index) {
          return Todo(
            title: todo.title,
            isCompleted: !todo.isCompleted,
          );
        }
        return todo;
      }).toList();
      emit(updatedTodos);
    });
  }

  Stream<List<Todo>> mapEventToState(TodoEvent event) async* {
    // No need to implement this method since event handlers are registered in the constructor.
  }
}

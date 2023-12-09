abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;

  AddTodoEvent(this.title);
}

class ToggleTodoEvent extends TodoEvent {
  final int index;

  ToggleTodoEvent(this.index);
}

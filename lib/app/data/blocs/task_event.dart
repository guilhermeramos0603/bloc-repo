import 'package:bloc/app/data/models/task_model.dart';

abstract class TaskEvent {}

class GetTasks extends TaskEvent {}

class CreateTask extends TaskEvent {
  final TaskModel task;
  CreateTask({required this.task});
}

class DeleteTask extends TaskEvent {
  final TaskModel task;
  DeleteTask({required this.task});
}

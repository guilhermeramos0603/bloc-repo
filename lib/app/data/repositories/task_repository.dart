import 'package:bloc/app/data/models/task_model.dart';

class TaskRepository {
  final List<TaskModel> _task = [];

  Future<List<TaskModel>> createTask(TaskModel task) async {
    _task.add(task);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return _task;
  }

  Future<List<TaskModel>> getTasks() async {
    _task.addAll([
      TaskModel(name: "Pasta"),
      TaskModel(name: "Beans"),
      TaskModel(name: "Meat"),
      TaskModel(name: "Salad"),
    ]);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return _task;
  }

  Future<List<TaskModel>> deleteTask(TaskModel task) async {
    _task.remove(task);
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return _task;
  }
}

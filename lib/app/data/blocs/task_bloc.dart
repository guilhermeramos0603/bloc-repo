import 'dart:async';
import 'package:bloc/app/data/blocs/task_event.dart';
import 'package:bloc/app/data/blocs/task_state.dart';
import 'package:bloc/app/data/models/task_model.dart';
import 'package:bloc/app/data/repositories/task_repository.dart';

class TaskBloc {
  final _repository = TaskRepository();

  final StreamController<TaskEvent> _inputTaskController =
      StreamController<TaskEvent>();
  final StreamController<TaskState> _outputTaskController =
      StreamController<TaskState>();

  Sink<TaskEvent> get inputTask => _inputTaskController.sink;
  Stream<TaskState> get outputTask => _outputTaskController.stream;

  TaskBloc() {
    _inputTaskController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TaskEvent event) async {
    List<TaskModel> tasks = [];

    _outputTaskController.add(TaskLoadingState());

    if (event is GetTasks) {
      tasks = await _repository.getTasks();
    }

    if (event is CreateTask) {
      tasks = await _repository.createTask(event.task);
    }
    if (event is DeleteTask) {
      tasks = await _repository.deleteTask(event.task);
    }

    _outputTaskController.add(TaskLoadedState(tasks: tasks));
  }
}

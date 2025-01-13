import 'package:flutter/material.dart';
import 'package:bloc/app/data/blocs/task_bloc.dart';
import 'package:bloc/app/data/blocs/task_state.dart';
import 'package:bloc/app/data/blocs/task_event.dart';
import 'package:bloc/app/data/models/task_model.dart';

class TaskPage extends StatefulWidget {
  final String title;
  const TaskPage({super.key, required this.title});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = TaskBloc();
    _taskBloc.inputTask.add(GetTasks());
  }

  @override
  void dispose() {
    super.dispose();
    _taskBloc.inputTask.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<TaskState>(
          stream: _taskBloc.outputTask,
          builder: (context, state) {
            if (state.data is TaskLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.data is TaskLoadedState) {
              final list = state.data?.tasks ?? [];
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: list.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Center(
                      child: Text(
                        list[index].name[0],
                      ),
                    ),
                  ),
                  title: Text(list[index].name),
                  trailing: IconButton(
                      onPressed: () {
                        _taskBloc.inputTask.add(
                          DeleteTask(
                            task: list[index],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete)),
                ),
              );
            }

            return const Center(
              child: Text("ERROR"),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskBloc.inputTask
              .add(CreateTask(task: TaskModel(name: "Abacazzo")));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

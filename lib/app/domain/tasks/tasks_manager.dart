import 'dart:collection';

class TasksManager {
  int _currentTasks = 0;
  static const int _maxTasks = 5;
  static const int _overflowTask = 6;
  final Queue<Function> _tasks = Queue();


  void _checkOverflow() {
    if (_tasks.length > _overflowTask) {
      _tasks.clear();
      _currentTasks = 0;
    }
  }

  void addTask(Function task) {
    _checkOverflow();
    _tasks.add(task);
    _proccessTasks();
  }

  void releaseTask() {
    _currentTasks--;
    _proccessTasks();
  }

  void killAllTasks() {
    _currentTasks = 0;
    _tasks.clear();
  }

  void _proccessTasks() {
    while (_tasks.isNotEmpty && _currentTasks < _maxTasks) {
      final task = _tasks.removeFirst();
      _currentTasks++;
      task();
    }
  }

}

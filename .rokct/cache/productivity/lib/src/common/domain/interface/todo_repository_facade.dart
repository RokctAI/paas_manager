abstract class TodoRepositoryFacade {
  /// Loads tasks from local storage
  Future<List<Map<String, dynamic>>> loadTodos();

  /// Saves the current list of tasks to local storage
  Future<void> saveTodos(List<Map<String, dynamic>> todos);

  /// Exports the tasks to a file and triggers a share dialog
  Future<void> exportTodos(List<Map<String, dynamic>> todos);
}

import 'package:clean_architecture/domain/model/todo.dart';

import '../../domain/repository/todos.dart';
// import '../source/database/database.dart';

class TodosRepositorySid implements TodosRepository {
  final lista = <Todo>[];

  @override
  Future<int> add(Todo todo) async {
    lista.add(todo);
    // final result = await database.execute(
    //   '''
    //   INSERT INTO todos (title, completed) VALUES (?, ?) RETURNING id;
    //   ''',
    //   params: [todo.title, todo.completed],
    // );
    // return result.last['id'] as int;
    return lista.length - 1;
  }

  @override
  Future<List<Todo>> getAll() async {
    // final todos = await database.get(_selectSql);
    // return todos.map(Todo.fromJson).toList();
    return lista;
  }

  @override
  Future<void> remove(Todo todo) async {
    // await database.execute(
    //   '''
    //   DELETE FROM todos WHERE id = ?;
    //   ''',
    //   params: [todo.id],
    // );
    lista.remove(todo);
  }

  @override
  Future<void> update(Todo todo) async {
    // await database.execute(
    //   '''
    //   UPDATE todos SET title = ?, completed = ? WHERE id = ?;
    //   ''',
    //   params: [todo.title, todo.completed, todo.id],
    // );
    lista[todo.id] = todo;
  }

  @override
  Future<Todo?> get(int id) async {
    // final result = await database.getSingleOrNull(
    //   'SELECT * FROM todos WHERE id = ?;',
    //   params: [id],
    // );
    // if (result == null) {
    //   return null;
    // } else {
    //   return Todo.fromJson(result);
    // }
    return lista[id];
  }

  @override
  Future<void> removeCompleted() async {
    // await database.execute(
    //   '''
    //   DELETE FROM todos WHERE completed = 1;
    //   ''',
    // );
    lista.removeWhere((todo) => todo.completed < 1);
  }

  @override
  Stream<List<Todo>> watchAll() {
    // return database.watch(
    //   _selectSql,
    //   triggerOnTables: ['todos'],
    // ).map((todos) => todos.map(Todo.fromJson).toList());
    return Stream.fromFuture(getAll());
  }
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';

const todoListKey = 'todo_list';

class TodoRepository {
  TodoRepository() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      print(sharedPreferences.getString('todo_list'),
      );
    });
  }

  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
   final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
   final List jsonDecoded = json.decode(jsonString) as List;
  return jsonDecoded.map((e) => Todo.fromJson(e)).toList();

  }

  void saveTodoList(List<Todo> todos) {
    final jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);
  }
}

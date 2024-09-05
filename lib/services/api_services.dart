import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  //Fetch all todo items
  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Todo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to Load Todos');
    }
  }

  //create a todo item
  Future<Todo> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-tYPE": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  //Update an existing todo item
  Future<Todo> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${todo.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Update todo');
    }
  }

  //delete a todo item
  Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}

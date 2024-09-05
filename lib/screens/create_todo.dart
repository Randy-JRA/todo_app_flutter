import 'package:flutter/material.dart';

import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/api_services.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController todoController = TextEditingController();
  ApiService apiService = ApiService();
  bool isLoading = false;

  Future<void> saveTodo() async {
    if (todoController.text.isNotEmpty) {
      setState(() {
        isLoading = true; // Show loading indicator
      });

      // Create a Todo object with some dummy data (e.g., id=0 for new todos)
      Todo newTodo = Todo(
        id: 0, // This will be automatically assigned by the API
        title: todoController.text,
        completed: false,
      );

      try {
        await apiService.createTodo(newTodo);
        // Clear the input field after saving
        todoController.clear();

        // Show success message or navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Todo created successfully!')),
        );
      } catch (e) {
        // Show error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create todo')),
        );
      } finally {
        setState(() {
          isLoading = false; // Hide loading indicator
        });
      }
    } else {
      // Show validation message if the input is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a todo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Todo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: todoController,
                decoration: InputDecoration(
                  hintText: 'Enter Todo',
                ),
              ),
              SizedBox(height: 5),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: saveTodo,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text('Save'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo_crud/app/model/todo.dart';
import 'package:flutter_todo_crud/app/service/todo_service.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late Todo newTodo;
  late TextEditingController todoNameController;
  late TextEditingController todoDescController;
  String tag = '업무';
  String date = '';
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    todoNameController = TextEditingController();
    todoDescController = TextEditingController();
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: todoNameController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: todoDescController,
              decoration: const InputDecoration(labelText: '내용'),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField<String>(
              value: tag,
              decoration: const InputDecoration(labelText: '태그'),
              onChanged: (newValue) {
                setState(() {
                  tag = newValue!;
                });
              },
              items: ['업무', '공부', '운동', '기타'].map(
                (tag) {
                  return DropdownMenuItem(value: tag, child: Text(tag));
                },
              ).toList(),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                _showDatePicker();
                date = selectedDate.toString().substring(0, 10);
              },
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(selectedDate.toString().substring(0, 10))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                newTodo = Todo(
                    todoName: todoNameController.text,
                    todoDesc: todoDescController.text,
                    todoTag: tag,
                    todoDate: date);
                addTodo(newTodo, context);
              },
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}

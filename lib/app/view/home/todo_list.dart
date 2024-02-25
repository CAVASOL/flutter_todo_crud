import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_crud/app/model/todo.dart';
import 'package:flutter_todo_crud/app/service/todo_service.dart';

import 'todo_list_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late FirebaseFirestore firestore;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: StreamBuilder<List<Todo>>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data.'),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return TodoListItem(todo: snapshot.data![index]);
              },
              itemCount: snapshot.data!.length,
            );
          }
        },
        stream: getTodoList(firestore),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../models/todo.model.dart';
import '../stores/todo.store.dart';

final todoStore = TodoStore();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Observer(
        builder: (context) => Text(todoStore.todos.length.toString()),
      )),
      body: Observer(
          builder: (context) => ListView.builder(
              itemCount: todoStore.todos.length,
              itemBuilder: (context, index) {
                var todo = todoStore.todos[index];
                return Text(todo.title.toString());
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var todo = new Todo(id: 1, title: 'Testando', done: false);
          todoStore.add(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

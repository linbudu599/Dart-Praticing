import "package:flutter/material.dart";

class TodoItem {
  final String title;
  final String description;

  TodoItem(this.title, this.description);
}

class DataSend2NewScreen extends StatefulWidget {
  DataSend2NewScreen({Key key}) : super(key: key);

  @override
  _DataSend2NewScreenState createState() => _DataSend2NewScreenState();
}

class _DataSend2NewScreenState extends State<DataSend2NewScreen> {
  final List<TodoItem> todos = List<TodoItem>.generate(
      20, (index) => TodoItem("Item $index", "Desc $index"));

  @override
  Widget build(BuildContext context) {
    return TodoScreen(
      todos: todos,
    );
  }
}

class TodoScreen extends StatelessWidget {
  final List<TodoItem> todos;

  const TodoScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Text(todos[idx].title),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(todo: todos[idx])));
                },
              );
            }));
  }
}

class DetailScreen extends StatelessWidget {
  final TodoItem todo;

  const DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}

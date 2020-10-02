import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(uri: 'http://10.0.2.2:3000'),
  ),
);

final String getTasksQuery = """
query {
  allTodos {
    id,
    title,
    completed
  }
}
""";

final String createTaskMutation = """
mutation CreateTodo(\$id: ID!, \$title: String!) {
  createTodo(id: \$id, title: \$title, completed: false) {
    id
  }
}
""";

final String updateTaskMutation = """
mutation UpdateTodo(\$id: ID!, \$completed: Boolean!) {
  updateTodo(id: \$id, completed: \$completed) {
    id
  }
}
""";

void main() {
  runApp(GraphQLToDoDemo());
}

class GraphQLToDoDemo extends StatelessWidget {
  const GraphQLToDoDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: "GraphQLToDo Demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ListPage(),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final newTaskController = TextEditingController();

  Future<String> onCreate(BuildContext context, dynamic id) async {
    return showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => Mutation(
            options: MutationOptions(documentNode: gql(createTaskMutation)),
            builder: (RunMutation runMutation, QueryResult result) =>
                AlertDialog(
                  title: Text('Enter New Task'),
                  content: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: "Task Description",
                            hintText: "Do Stuff",
                            errorText: result.hasException
                                ? result.exception.toString()
                                : null,
                          ),
                          controller: newTaskController,
                        ),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          runMutation(
                              {"title": newTaskController.text, "id": "id"});

                          Navigator.of(context).pop();
                        },
                        child: Text("Create"))
                  ],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(documentNode: gql(getTasksQuery)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Scaffold(
            appBar: AppBar(
              title: Text("GraphQL ToDo Demo"),
            ),
            body: Center(
              child: result.hasException
                  ? Text(result.exception.toString())
                  : result.loading
                      ? CircularProgressIndicator()
                      : TaskList(
                          list: result.data['allTodos'], onRefresh: refetch),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: "Add New Task",
              child: Icon(Icons.add),
              onPressed: () => (!result.hasException && !result.loading)
                  ? this.onCreate(context, result.data['allTodos'].length)
                  : () {},
            ),
          );
        });
  }
}

class TaskList extends StatelessWidget {
  final List<dynamic> list;
  final VoidCallback onRefresh;

  const TaskList({Key key, @required this.list, @required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Mutation(
        options: MutationOptions(documentNode: gql(updateTaskMutation)),
        builder: (RunMutation runMutation, QueryResult result) =>
            ListView.builder(
              itemCount: this.list.length,
              itemBuilder: (BuildContext context, int idx) {
                final currentTask = this.list[idx];

                return CheckboxListTile(
                    title: Text(currentTask['title']),
                    value: currentTask['completed'],
                    onChanged: (_) {
                      runMutation({
                        "id": idx + 1,
                        'completed': !currentTask['completed']
                      });
                      print("1");
                      onRefresh();
                    });
              },
            ));
  }
}

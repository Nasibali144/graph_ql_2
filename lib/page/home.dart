import 'package:flutter/material.dart';
import 'package:graph_ql_2/service/graph_ql/gql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> list = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  void fetchTodo() async {
    final QueryResult result = await GQLService.gql.query(QueryOptions(
      document: gql(GQLRequest.queryTodo),
    ));

    if(result.data != null) {
      print(result.data);
      list = (result.data!["todos"] as List).map((json) => Todo.fromJson(Map<String, Object?>.from(json as Map))).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (_, i) {
          final todo = list[i];
          return Card(
            child: ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.userId),
            ),
          );
        },
      ),
    );
  }
}

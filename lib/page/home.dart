import 'package:flutter/cupertino.dart';
import 'package:graph_ql_2/service/graph_ql/gql_service.dart';
import 'package:graph_ql_2/service/util.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> list = [];
  final titleCtrl = TextEditingController();

  void completeTodo(Todo todo) async {
    todo.isCompleted = !todo.isCompleted;
    await GQLService.gql.mutate(MutationOptions(
        document: gql(GQLRequest.mutationEditTodo(todo.id, todo.isCompleted))));
  }

  void deleteTodo(Todo todo) async {
    todo.isCompleted = !todo.isCompleted;
    await GQLService.gql.mutate(
        MutationOptions(document: gql(GQLRequest.mutationDeleteTodo(todo.id))));
  }

  void createTodo(String title, BuildContext context) async {
    final QueryResult result = await GQLService.gql.mutate(MutationOptions(
        document: gql(GQLRequest.mutationCreateTodo(title, false))));

    if (result.data != null && context.mounted) {
      Navigator.of(context).pop();
      titleCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mutation
    // Query
    // Subscription

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Todos"),
        trailing: CupertinoButton(
            onPressed: () => showCreateDialog(context),
            child: const Icon(CupertinoIcons.pencil)),
      ),
      child: Subscription(
        builder: (result) {
          if (result.data != null) {
            debugPrint(result.data.toString());
            list = (result.data!["todos"] as List)
                .map((json) =>
                    Todo.fromJson(Map<String, Object?>.from(json as Map)))
                .toList();
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 120),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final todo = list[i];
              return CupertinoListTile(
                leading: CupertinoCheckbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    debugPrint(value.toString());
                    completeTodo(todo);
                  },
                ),
                title: Text(todo.title),
                subtitle: Text(Utils.formatDate(todo.createdAt)),
                trailing: CupertinoButton(
                  onPressed: () {
                    deleteTodo(todo);
                  },
                  child: const Icon(CupertinoIcons.delete),
                ),
              );
            },
          );
        },
        options: SubscriptionOptions(
          document: gql(GQLRequest.queryTodosSubscription),
        ),
      ),
    );
  }

  void showCreateDialog(BuildContext context) => showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Create Todo'),
            content: Padding(
              padding: const EdgeInsets.all(15),
              child: CupertinoTextField(
                controller: titleCtrl,
                placeholder: "Title",
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                onPressed: () => createTodo(titleCtrl.text, context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
}

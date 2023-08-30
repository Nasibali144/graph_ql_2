import 'package:flutter/material.dart';
import 'package:graph_ql_2/app.dart';
import 'package:graph_ql_2/service/graph_ql/gql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(
    GraphQLProvider(
      client: GQLService.client,
      child: const LearnGQL(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

sealed class GQLService {

  /// setting and connecting url
  static final HttpLink _httpLink = HttpLink('https://hasura.io/learn/graphql');

  static final AuthLink _authLink = AuthLink(
    getToken: () async => 'Your Token',
  );

  static final Link link = _authLink.concat(_httpLink);

  /// controller
  static GraphQLClient get gql => GraphQLClient(cache: GraphQLCache(), link: link);
  static ValueNotifier<GraphQLClient> client = ValueNotifier(gql);
}

sealed class GQLRequest {
  static const queryTodo = """
query{
  todos {
    id
    is_completed
    created_at
    is_public
    title
    user_id
  }
}  
  """;
}
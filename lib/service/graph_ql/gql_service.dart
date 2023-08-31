import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

sealed class GQLService {
  /// setting and connecting url
  static final HttpLink _httpLink = HttpLink('https://hasura.io/learn/graphql');

  static final AuthLink _authLink = AuthLink(
    getToken: () async =>
        'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY0ZWViYTI3NjQ1MjhhZmFmNDE0YmRjOSJ9LCJuaWNrbmFtZSI6ImFiZGl5ZXZuYXNpYmFsaSIsIm5hbWUiOiJhYmRpeWV2bmFzaWJhbGlAZ21haWwuY29tIiwicGljdHVyZSI6Imh0dHBzOi8vcy5ncmF2YXRhci5jb20vYXZhdGFyLzJhMWM1OTA1ODVlZWU2OGE2MTM2ZDQ0NGI0MTdkYmEzP3M9NDgwJnI9cGcmZD1odHRwcyUzQSUyRiUyRmNkbi5hdXRoMC5jb20lMkZhdmF0YXJzJTJGYWIucG5nIiwidXBkYXRlZF9hdCI6IjIwMjMtMDgtMzBUMDM6NDA6MjUuMjM2WiIsImlzcyI6Imh0dHBzOi8vZ3JhcGhxbC10dXRvcmlhbHMuYXV0aDAuY29tLyIsImF1ZCI6IlAzOHFuRm8xbEZBUUpyemt1bi0td0V6cWxqVk5HY1dXIiwiaWF0IjoxNjkzNDUzOTQwLCJleHAiOjE2OTM0ODk5NDAsInN1YiI6ImF1dGgwfDY0ZWViYTI3NjQ1MjhhZmFmNDE0YmRjOSIsImF0X2hhc2giOiIta1lHVzJxa3Zqb2JHRTJRREpOX2l3Iiwic2lkIjoiQlJZQVVMMTliNE9YLXRZRlBNeV9ZSUZuMVFOSTAtQ0siLCJub25jZSI6Ii1HMFlWUmFfRjNxdn50UDl5VUxlS3NxTTVSMnpFazJ0In0.O9bydCJlISbZnsWwJ7DMEkPY3nx0lC_jzd1RzGxQDhW7tCp73sfpE4BBuzxcXUJNrApQ80riX-_QlGQF_BgKkYBQXTaVhr3WZCkQbgUCvJQY2H-qeiJ5kh0yPd2zk1C-Nna3tFVQq8yAQnNBzlawpJuR6QNbSXSIz62HSis868tuu8FwWAHOv2hqWWZq1XMTfEkxaAliPYuXPYngCDrK0Iszf54FG4u9rMJzxnRUTstNbB0yeN1w0qTePmPTznaJpVf6VtQwoquV_km86kQzVV03qbmp2UpkgbCARkmEcNS6UQv4wqXz7_GW42xJ9aIGyu6egJx4xQML0PEVp4_kiA',
  );

  static final _socketLink = WebSocketLink("wss://hasura.io/learn/graphql",
      subProtocol: GraphQLProtocol.graphqlWs,
      config: SocketClientConfig(initialPayload: () async {
    return {
      'headers': {
        "Content-Type": "application/json",
        'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDY0ZWViYTI3NjQ1MjhhZmFmNDE0YmRjOSJ9LCJuaWNrbmFtZSI6ImFiZGl5ZXZuYXNpYmFsaSIsIm5hbWUiOiJhYmRpeWV2bmFzaWJhbGlAZ21haWwuY29tIiwicGljdHVyZSI6Imh0dHBzOi8vcy5ncmF2YXRhci5jb20vYXZhdGFyLzJhMWM1OTA1ODVlZWU2OGE2MTM2ZDQ0NGI0MTdkYmEzP3M9NDgwJnI9cGcmZD1odHRwcyUzQSUyRiUyRmNkbi5hdXRoMC5jb20lMkZhdmF0YXJzJTJGYWIucG5nIiwidXBkYXRlZF9hdCI6IjIwMjMtMDgtMzBUMDM6NDA6MjUuMjM2WiIsImlzcyI6Imh0dHBzOi8vZ3JhcGhxbC10dXRvcmlhbHMuYXV0aDAuY29tLyIsImF1ZCI6IlAzOHFuRm8xbEZBUUpyemt1bi0td0V6cWxqVk5HY1dXIiwiaWF0IjoxNjkzNDUzOTQwLCJleHAiOjE2OTM0ODk5NDAsInN1YiI6ImF1dGgwfDY0ZWViYTI3NjQ1MjhhZmFmNDE0YmRjOSIsImF0X2hhc2giOiIta1lHVzJxa3Zqb2JHRTJRREpOX2l3Iiwic2lkIjoiQlJZQVVMMTliNE9YLXRZRlBNeV9ZSUZuMVFOSTAtQ0siLCJub25jZSI6Ii1HMFlWUmFfRjNxdn50UDl5VUxlS3NxTTVSMnpFazJ0In0.O9bydCJlISbZnsWwJ7DMEkPY3nx0lC_jzd1RzGxQDhW7tCp73sfpE4BBuzxcXUJNrApQ80riX-_QlGQF_BgKkYBQXTaVhr3WZCkQbgUCvJQY2H-qeiJ5kh0yPd2zk1C-Nna3tFVQq8yAQnNBzlawpJuR6QNbSXSIz62HSis868tuu8FwWAHOv2hqWWZq1XMTfEkxaAliPYuXPYngCDrK0Iszf54FG4u9rMJzxnRUTstNbB0yeN1w0qTePmPTznaJpVf6VtQwoquV_km86kQzVV03qbmp2UpkgbCARkmEcNS6UQv4wqXz7_GW42xJ9aIGyu6egJx4xQML0PEVp4_kiA',
      },
    };
  }));

  static final Link _linkHttp = _authLink.concat(_socketLink);
  static final Link link = _linkHttp.concat(_httpLink);

  /// controller
  static GraphQLClient get gql =>
      GraphQLClient(cache: GraphQLCache(), link: link);
  static ValueNotifier<GraphQLClient> client = ValueNotifier(gql);
}

sealed class GQLRequest {
  static const queryTodoAll = """
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

  static const queryTodosSubscription = """
subscription {
  todos(order_by: {created_at: desc}, where: {user_id: {_eq: "auth0|64eeba2764528afaf414bdc9"}}) {
    created_at
    id
    is_completed
    is_public
    title
    user_id
  }
} 
  """;

  static String queryTodoMe(
          [String userId = "auth0|64eeba2764528afaf414bdc9"]) =>
      """
{
  todos(where: {user_id: {_eq: "$userId"}}) {
    created_at
    id
    is_completed
    is_public
    title
    user_id
  }
} 
  """;

  static String mutationEditTodo(int todoId, bool isCompleted) {
    return """
mutation {
  update_todos(where: {id: {_eq: $todoId}}, _set: {is_completed: $isCompleted}) {
    affected_rows
    returning {
      created_at
      id
      is_completed
      is_public
      title
      user_id
    }
  }
}
    """;
  }

  static String mutationCreateTodo(String title, bool isPublic) {
    return """
mutation {
  insert_todos(objects: {is_public: $isPublic, title: "$title"}) {
    affected_rows
    returning {
      created_at
      id
      is_completed
      is_public
      title
      user {
        id
        name
      }
      user_id
    }
  }
}
    """;
  }

  static String mutationDeleteTodo(int todoId) {
    return """
mutation {
  delete_todos(where: {id: {_eq: $todoId}}) {
    affected_rows
    returning {
      created_at
      id
      is_completed
      is_public
      title
      user_id
    }
  }
}
    """;
  }
}

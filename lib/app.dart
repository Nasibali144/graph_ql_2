import 'package:flutter/material.dart';
import 'package:graph_ql_2/page/home.dart';

class LearnGQL extends StatelessWidget {
  const LearnGQL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const Home(),
    );
  }
}

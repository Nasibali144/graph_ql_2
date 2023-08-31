import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph_ql_2/page/home.dart';

class LearnGQL extends StatelessWidget {
  const LearnGQL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid
    || Platform.isFuchsia
    || Platform.isLinux
    || Platform.isWindows) {
      return MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        home: const Home(),
      );
    }

    return const CupertinoApp(
      home: Home(),
    );
  }
}

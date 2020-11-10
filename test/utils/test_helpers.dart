import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget testWidget(
  Widget testWidget, {
  List<BlocProvider> providers = const [],
}) {
  return MultiBlocProvider(
    providers: providers,
    child: MaterialApp(
      home: testWidget,
    ),
  );
}

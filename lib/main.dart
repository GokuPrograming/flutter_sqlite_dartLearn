import 'package:flutter/material.dart';
import 'package:movieapp/routes/routes.dart';
import 'package:movieapp/screen/main.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Material App',
        home: const Main(),
        theme: ThemeData.light(),
        routes: Routes.routes,
      ),
    );
  }
}

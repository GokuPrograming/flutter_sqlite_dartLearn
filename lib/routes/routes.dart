import 'package:flutter/material.dart';
import 'package:movieapp/screen/main.dart';

class Routes {
  static const main = '/main';

  static final routes = <String, WidgetBuilder>{
    main: (context) => const Main()
  };
}

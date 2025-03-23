/// Пример использования ServicesBinding
/// для прослушивания ввода с клавиатуры
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ServicesBinding.instance.keyboard.addHandler((event) {
    print('Key pressed: ${event.logicalKey}');
    return true;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(title: Text('ServicesBinding Example')), body: Center(child: TextField())),
    );
  }
}

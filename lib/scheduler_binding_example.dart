/// Пример использования SchedulerBinding
/// для вывода размера контейнера с конкретным размером
/// в реальном времени.
library;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey myKey = GlobalKey();
  String message = "";

  @override
  void initState() {
    super.initState();
    _calculateSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SchedulerBinding Example")),
      body: LayoutBuilder(
        builder: (_, __) {
          _calculateSize();
          return Stack(
            children: [
              Align(alignment: Alignment.topCenter, child: Text("Message: $message")),
              Padding(
                padding: const EdgeInsets.all(100),
                child: Center(child: Container(key: myKey, color: Colors.red)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _calculateSize() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      RenderBox logoBox = myKey.currentContext!.findRenderObject() as RenderBox;

      message = "Size: ${logoBox.size}";
      setState(() {});
    });
  }
}

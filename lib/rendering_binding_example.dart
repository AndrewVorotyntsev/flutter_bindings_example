/// Пример использования RendererBinding
/// для отложенной отрисовки кадров приложения.
library;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Можно отложить первый кадр приложения и остаться на сплеш экране
  RendererBinding.instance.deferFirstFrame();
  // Делаем асинхронную операцию по получению цвета.
  final myColor = await getMyColor();
  // Разрешаем отрисовку кадров.
  RendererBinding.instance.allowFirstFrame();

  // Если не использовать deferFirstFrame() то будут логи в консоли:
  // I/Choreographer( 6937): Skipped 30 frames!  The application may be doing too much work on its main thread.


  runApp(MyApp(myColor: myColor));
}

Future<Color> getMyColor() async {
  await Future.delayed(const Duration(seconds: 1));

  return Colors.green;
}

class MyApp extends StatelessWidget {
  final Color myColor;
  const MyApp({super.key, required this.myColor});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: myColor)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.light_mode)),
    );
  }
}

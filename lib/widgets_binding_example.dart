/// Использование WidgetsBinding
/// для отслеживания изменений языка устройства.
library;

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(title: Text('WidgetBinding Example')), body: Center(child: MyWidget())),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with WidgetsBindingObserver {
  String currentLocale = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    currentLocale = WidgetsBinding.instance.platformDispatcher.locale.toString();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locale) {
    print('didChangeLocales $locale');
    setState(() {
      currentLocale = locale!.first.toString();
    });
    super.didChangeLocales(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(currentLocale));
  }
}

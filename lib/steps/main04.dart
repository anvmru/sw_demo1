import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:wearable_rotary/wearable_rotary.dart';

/*
  Управление счетчиком через поворотный интерфейс
  установка (MainActivity.kt):
  https://pub.dev/packages/wearable_rotary
*/

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientMode(
      child: const MyHomePage(title: 'Demo #1'),
      builder: (BuildContext context, WearMode mode, Widget? child) {
        return MaterialApp(
          title: 'Demo 1',
          home: child,
          theme: _themeData(mode),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  // Меняем общую тему в зависимости от режима
  ThemeData _themeData(WearMode mode) {
    return mode == WearMode.active
        ? ThemeData(
            visualDensity: VisualDensity.compact,
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00B5FF),
            ),
          )
        : ThemeData(
            visualDensity: VisualDensity.compact,
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
              // dark colorscheme
              primary: Colors.white24,
              onBackground: Colors.white10,
              onSurface: Colors.white24,
            ),
            textTheme: const TextTheme(
              headline4: TextStyle(color: Colors.white24),
              bodyText2: TextStyle(color: Colors.white10),
            ),
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
  int _counter = 0;

  // Управление поворотным механизмом ------------------
  late final StreamSubscription<RotaryEvent> rotarySubscription;

  @override
  void initState() {
    // Создание подписки
    rotarySubscription = rotaryEvents.listen(rotaryEventListener);
    super.initState();
  }

  @override
  void dispose() {
    // Удаление слушателя
    rotarySubscription.cancel();
    super.dispose();
  }

  void rotaryEventListener(RotaryEvent event) {
    if (event.direction == RotaryDirection.clockwise) {
      _incrementCounter();
    } else {
      _decrementCounter();
    }
  }
  // -----------------------------------------------------------------

  void _incrementCounter() => setState(() => _counter++);
  void _decrementCounter() => setState(() => --_counter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: CounterText(counter: _counter),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          ),
        ],
      ), //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key, required this.counter});
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        const Text('Нажимайте кнопки сколько хотите:',
            textAlign: TextAlign.center),
        Text(counter.toString(), style: Theme.of(context).textTheme.headline4),
      ],
    );
  }
}

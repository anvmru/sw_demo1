import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

/*
  Включаем поддержку AmbientMode (режим малого потребления - low power):
  изменяем цветовую тему в зависимости от режима
  https://medium.com/flutter-community/flutter-building-wearos-app-fedf0f06d1b4
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
            // монохромная тема в режиме малого потребления
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
              bodyText2: TextStyle(color: Colors.red),
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

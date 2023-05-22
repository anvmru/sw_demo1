import 'package:flutter/material.dart';

/*
  step 2
  Адаптация для Watch
  - используем темную тему
  - включаем поддержку material 3
  - устанавливаем отступы согласно рекомендациям для Wear OS:
  https://developer.android.com/training/wearables/design/screen-shapes
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo 1',
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        useMaterial3: true, // use material 3
        colorScheme: const ColorScheme.dark(
          // dark colorscheme
          primary: Colors.white24,
          onBackground: Colors.white10,
          onSurface: Colors.white24,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Demo #1'),
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
        SizedBox(height: 8),
        const Text('You have pushed the button this many times:',
            textAlign: TextAlign.center),
        Text(counter.toString(), style: Theme.of(context).textTheme.headline4),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear/wear.dart';
import 'package:wearable_rotary/wearable_rotary.dart';
import 'package:sw_demo1/vibrate_helper.dart';

/*
  step 6
  Добавлена вибрация при работе счетчиков
  одинарная при инкременте и двойная при декременте
*/

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientMode(
      child: const MyHomePage(title: 'Demo #1'),
      builder: (BuildContext context, WearMode mode, Widget? child1) {
        return ScreenUtilInit(
            designSize: const Size(450, 450),
            builder: (context, child2) {
              return MaterialApp(
                title: 'Demo 1',
                theme: _themeData(mode),
                debugShowCheckedModeBanner: false,
                home: child2,
              );
            },
            child: child1);
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

  void _incrementCounter() => setState(() {
        _counter++;
        VibrateHelper.vibrateOne();
      });
  void _decrementCounter() => setState(() {
        --_counter;
        VibrateHelper.vibrateTwo();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Center(child: CounterText(counter: _counter)),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onPressed: _decrementCounter,
            child: const Icon(Icons.remove),
          ),
          SizedBox(width: 20.w),
          FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 60.h),
        Text(counter.toString(), style: Theme.of(context).textTheme.headline4),
        const Text('Нажимайте кнопки\nсколько хотите',
            textAlign: TextAlign.center),
      ],
    );
  }
}

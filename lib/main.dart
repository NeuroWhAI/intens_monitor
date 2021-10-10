import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import 'src/earthquake.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intens Monitor',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Intens Monitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ResumableState<MyHomePage> {
  double _intens = 0;
  double _lastIntens = 0;
  double _maxIntens = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Wakelock.enable();

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      double maxIntens = _maxIntens;
      _maxIntens = _lastIntens;
      setState(() {
        _intens = maxIntens;
      });
    });

    userAccelerometerEvents.listen((event) {
      _lastIntens =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z) /
              9.80665;
      if (_lastIntens > _maxIntens) {
        _maxIntens = _lastIntens;
      }
    });
  }

  @override
  void onResume() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    int mmi = gToMmi(_intens);
    String mmiSym = mmiToSymbol(mmi);
    Color mmiBgColor = mmiToBgColor(mmi);
    Color mmiFgColor = mmiToFgColor(mmi);
    double jma = gToJma(_intens);
    String jmaSym = jmaToSymbol(jma);
    Color jmaBgColor = jmaToBgColor(jma);
    Color jmaFgColor = jmaToFgColor(jma);

    return Scaffold(
      body: SafeArea(
        child: OrientationSwitcher(
          children: <Widget>[
            Expanded(
                child: Container(
              color: mmiBgColor,
              padding: const EdgeInsets.all(24),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Center(
                  child: Text(
                    mmiSym,
                    style: TextStyle(color: mmiFgColor, letterSpacing: -1.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )),
            Expanded(
                child: Container(
              color: jmaBgColor,
              padding: const EdgeInsets.all(24),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Center(
                  child: Text(
                    jmaSym,
                    style: TextStyle(color: jmaFgColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class OrientationSwitcher extends StatelessWidget {
  final List<Widget> children;

  const OrientationSwitcher({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Column(
            children: children,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
          )
        : Row(
            children: children,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
          );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_utils/fl_utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const kCardW = 400.0;
    const kCardH = 100.0;

    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      // allow mouse to drag.
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('SizedScrollableArea Example')),

        // [ListView] maintain it sizes, but can be scrolled without pointing the
        // actual [ListView].
        body: PrimaryScrollController(
          controller: ScrollController(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // scrollable area that fill all available space
              const SizedScrollableArea(primary: true),

              // centered fixed width [ListView]
              Center(
                child: SizedBox(
                  width: kCardW,
                  child: ListView.builder(
                    primary: true,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: 50,
                    itemBuilder: (_, index) => SizedBox(
                      height: kCardH,
                      child: Card(child: Center(child: Text('#${index + 1}'))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

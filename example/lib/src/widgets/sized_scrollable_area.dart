import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDefaultExample = true;
  bool isReversed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      // allow mouse to drag.
      scrollBehavior: context.scrollBehavior.copyWith(
        dragDevices: {
          ...context.scrollBehavior.dragDevices,
          PointerDeviceKind.mouse,
        },
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('SizedScrollableArea Example')),
        body: SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() => isDefaultExample = !isDefaultExample);
                    },
                    child: Text(
                      isDefaultExample
                          ? 'Axis.vertical example'
                          : 'Axis.horizontal example',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () => setState(() => isReversed = !isReversed),
                    child: Text(
                      isReversed ? 'reverse direction' : 'default direction',
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: isDefaultExample
                    ? VerticalExample(isReversed: isReversed)
                    : HorizontalExample(isReversed: isReversed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerticalExample extends StatelessWidget {
  const VerticalExample({super.key, this.isReversed = false});

  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    const kCardW = 400.0;
    const kCardH = 100.0;

    // [ListView] maintain it sizes, but can be scrolled without pointing the
    // actual [ListView].
    return PrimaryScrollController(
      controller: ScrollController(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // scrollable area that fill all available space
          SizedScrollableArea(primary: true, reverse: isReversed),

          // centered fixed width [ListView]
          Center(
            child: SizedBox(
              width: kCardW,
              child: ListView.builder(
                primary: true,
                reverse: isReversed,
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
    );
  }
}

class HorizontalExample extends StatelessWidget {
  const HorizontalExample({super.key, this.isReversed = false});

  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    const kCardDimension = 160.0;
    const direction = Axis.horizontal;

    // [ListView] maintain it sizes, but can be scrolled without pointing the
    // actual [ListView].
    return PrimaryScrollController(
      controller: ScrollController(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // scrollable area that fill all available space
          SizedScrollableArea(
            primary: true,
            scrollDirection: direction,
            reverse: isReversed,
          ),

          // centered fixed width [ListView]
          Center(
            child: SizedBox(
              height: kCardDimension,
              child: ListView.builder(
                primary: true,
                scrollDirection: direction,
                reverse: isReversed,
                padding: const EdgeInsets.all(16.0),
                itemCount: 50,
                itemBuilder: (_, index) => SizedBox(
                  width: kCardDimension - (16.0 * 2),
                  child: Card(child: Center(child: Text('#${index + 1}'))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

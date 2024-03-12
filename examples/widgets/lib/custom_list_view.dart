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
  bool isVertDirection = true;
  bool isReversed = false;
  CustomListViewItemAlignment crossAxisAlignment =
      CustomListViewItemAlignment.center;

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
        appBar: AppBar(title: const Text('CustomListView Example')),
        body: SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() => isVertDirection = !isVertDirection);
                    },
                    child: Text(
                      isVertDirection
                          ? 'scrollDirection: Axis.vertical'
                          : 'scrollDirection: Axis.horizontal',
                    ),
                  ),

                  //
                  ElevatedButton(
                    onPressed: () => setState(() => isReversed = !isReversed),
                    child: Text(
                      isReversed ? 'reverse: true' : 'reverse: false',
                    ),
                  ),

                  //
                  DropdownButton<CustomListViewItemAlignment>(
                    value: crossAxisAlignment,
                    onChanged: (value) => setState(() {
                      crossAxisAlignment = value!;
                    }),
                    items: CustomListViewItemAlignment.values.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e'),
                      );
                    }).toList(),
                  )
                ],
              ),
              const Divider(),
              Expanded(
                child: CustomListView.builder(
                  scrollDirection:
                      isVertDirection ? Axis.vertical : Axis.horizontal,
                  reverse: isReversed,
                  itemCount: 100,
                  itemBuilder: (_, index) => CustomListViewItemDelegate(
                    mainAxisLength: 160.0,
                    crossAxisLength: 240.0,
                    crossAxisAlignment: crossAxisAlignment,
                    child: Card(
                      child: InkWell(
                        onTap: () {},
                        child: Center(child: Text('#$index')),
                      ),
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

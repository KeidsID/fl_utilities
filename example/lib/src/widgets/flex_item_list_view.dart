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
  Axis scrollDirection = Axis.vertical;
  bool reverse = false;
  FlexItemListViewAlignment crossAxisAlignment =
      FlexItemListViewAlignment.center;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,

      // allow mouse to drag.
      scrollBehavior: context.scrollBehavior.copyWith(
        dragDevices: {
          ...context.scrollBehavior.dragDevices,
          PointerDeviceKind.mouse,
        },
      ),

      home: Scaffold(
        appBar: AppBar(title: const Text('FlexItemListView Example')),
        body: SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      scrollDirection == Axis.vertical
                          ? scrollDirection = Axis.horizontal
                          : scrollDirection = Axis.vertical;
                    }),
                    child: Text("scrollDirection: $scrollDirection"),
                  ),

                  //
                  ElevatedButton(
                    onPressed: () => setState(() => reverse = !reverse),
                    child: Text("reverse: $reverse"),
                  ),

                  //
                  DropdownButton<FlexItemListViewAlignment>(
                    value: crossAxisAlignment,
                    onChanged: (value) => setState(() {
                      crossAxisAlignment = value!;
                    }),
                    items: FlexItemListViewAlignment.values.map((e) {
                      return DropdownMenuItem(value: e, child: Text('$e'));
                    }).toList(),
                  )
                ],
              ),
              const Divider(),
              Expanded(
                child: FlexItemListView.builder(
                  scrollDirection: scrollDirection,
                  reverse: reverse,
                  padding: const EdgeInsets.all(16.0),
                  viewDelegate: FlexItemListViewDelegate(
                    mainAxisLength: 160.0,
                    crossAxisLength: 240.0,
                    crossAxisAlignment: crossAxisAlignment,
                  ),
                  itemCount: 20,
                  itemBuilder: (_, index) => FlexItemListViewItem(
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        child: Center(child: Text('Item ${index + 1}')),
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fl_utilities/fl_utilities.dart';

void main() => runApp(const CustomListViewExampleApp());

class CustomListViewExampleApp extends StatefulWidget {
  const CustomListViewExampleApp({super.key});

  @override
  State<CustomListViewExampleApp> createState() =>
      _CustomListViewExampleAppState();
}

class _CustomListViewExampleAppState extends State<CustomListViewExampleApp> {
  bool isVertDirection = true;
  bool isReversed = false;
  CustomListViewItemAlignment crossAxisAlignment =
      CustomListViewItemAlignment.center;

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
        appBar: AppBar(title: const Text('CustomListView Example')),
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
                  padding: const EdgeInsets.all(16.0),
                  viewDelegate: CustomListViewDelegate(
                    mainAxisLength: 160.0,
                    crossAxisLength: 240.0,
                    crossAxisAlignment: crossAxisAlignment,
                  ),
                  itemCount: 100,
                  itemBuilder: (_, index) => CustomListViewItemDelegate(
                    child: Card(
                      clipBehavior: Clip.hardEdge,
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

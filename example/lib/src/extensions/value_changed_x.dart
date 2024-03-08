import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

void main() => runApp(const ValueChangedXApp());

class ValueChangedXApp extends StatefulWidget {
  const ValueChangedXApp({super.key});

  @override
  State<ValueChangedXApp> createState() => _ValueChangedXAppState();
}

class _ValueChangedXAppState extends State<ValueChangedXApp> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: const Text('ValueChangedX.debounce Example')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() => text = value);
                }.debounce(),
              ),
              const SizedBox(height: 16.0),
              Text('text (delay 500ms): \n$text', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

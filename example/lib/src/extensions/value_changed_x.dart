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
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: const Text('ValueChangedX.debounce Example')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'TextField'),
                onChanged: (String value) {
                  setState(() => text = value);
                }.debounce(),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Debounced text will be print below: \n\n$text',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

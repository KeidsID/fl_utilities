import 'package:flutter/material.dart';
import 'package:fl_utils/fl_utils.dart';

void main() => runApp(const BuildContextXApp());

class BuildContextXApp extends StatefulWidget {
  const BuildContextXApp({super.key});

  @override
  State<BuildContextXApp> createState() => _BuildContextXAppState();
}

class _BuildContextXAppState extends State<BuildContextXApp> {
  bool isDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    const appColor = Colors.blue;

    return MaterialApp(
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: appColor),
      ),
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: appColor,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: Builder(builder: (context) {
        final colorScheme = context.colorScheme;
        final textTheme = context.textTheme;

        return Scaffold(
            appBar: AppBar(title: const Text('BuildContextX Example')),
            body: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: colorScheme.primary,
                  child: Text(
                    'Container: context.colorScheme.primary\n'
                    'Text.style: context.textTheme.bodyLarge\n'
                    'Text.color: context.colorScheme.onPrimary',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: colorScheme.secondary,
                  child: Text(
                    'Container: context.colorScheme.secondary\n'
                    'Text.style: context.textTheme.bodyMedium\n'
                    'Text.color: context.colorScheme.onSecondary',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: colorScheme.tertiary,
                  child: Text(
                    'Container: context.colorScheme.tertiary\n'
                    'Text.style: context.textTheme.bodySmall\n'
                    'Text.color: context.colorScheme.onTertiary',
                    style: textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onTertiary,
                    ),
                  ),
                ),
                const Divider(),
                ElevatedButton.icon(
                  onPressed: () => setState(() => isDarkTheme = !isDarkTheme),
                  icon: Icon(
                    isDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                  ),
                  label: Text('${isDarkTheme ? 'Dark' : 'Light'} Theme'),
                ),
              ],
            )));
      }),
    );
  }
}

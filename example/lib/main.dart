import 'package:flutter/material.dart';
import 'package:fl_utilities/fl_utilities.dart';

// more examples on https://github.com/KeidsID/fl_utils/tree/main/examples

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    const appColor = Colors.lightGreen;

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
          appBar: AppBar(title: const Text('fl_utils Example')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('BuildContextX example', style: textTheme.titleMedium),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () => setState(() => isDarkTheme = !isDarkTheme),
                  icon: Icon(
                    isDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                  ),
                  label: Text('${isDarkTheme ? 'Dark' : 'Light'} Theme'),
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: colorScheme.tertiary,
                  child: Text(
                    'Container: context.colorScheme.tertiary\n'
                    'Text.style: context.textTheme.bodySmall\n'
                    'Text.color: context.colorScheme.onTertiary',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onTertiary,
                    ),
                  ),
                ),
                const Divider(),

                //
                Text(
                  'TextX.applyOpacity example',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 16.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('opacity: 1.0'),
                        const Text('opacity: 0.8').applyOpacity(opacity: 0.8),
                        const Text('opacity: 0.6').applyOpacity(opacity: 0.6),
                        const Text('opacity: 0.4').applyOpacity(opacity: 0.4),
                        const Text('opacity: 0.2').applyOpacity(opacity: 0.2),
                        const Text('opacity: 0.4').applyOpacity(opacity: 0.4),
                        const Text('opacity: 0.6').applyOpacity(opacity: 0.6),
                        const Text('opacity: 0.8').applyOpacity(opacity: 0.8),
                        const Text('opacity: 1.0'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tutorial_acs_2/root.dart';
import 'package:flutter_gen/gen_l10n/app.localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      // removes the debug banner that hides the home button
      title: 'ACS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo, // instead of deepPurple
          brightness: Brightness.light,), // light or dark
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 20), // size of hello
        ),
        // see https://docs.flutter.dev/cookbook/design/themes
      ),
      home: const ScreenBlank(), // ScreenSpace()
      localizationsDelegates: [
        AppLocalizations.delegate,

      ],
      supportedLocales: [
        Locale('es'),
        Locale('en'),
        Locale('ca')
      ],
      locale: Locale('en'),
    );
  }
}

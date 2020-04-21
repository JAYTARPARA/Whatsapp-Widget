import 'package:country_code_picker/country_localizations.dart';
import 'package:dmwa/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: "WA Widget",
      // theme: ThemeData(
      //   fontFamily: 'Overpass',
      // ),
      // darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(),
      },
    );
  }
}

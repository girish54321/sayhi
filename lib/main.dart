import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:sayhi/screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          themeMode: ThemeMode.system,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: darkDynamic,
            scaffoldBackgroundColor: Colors.black,
          ),
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: lightDynamic,
          ),
          title: 'Flutter Demo',
          home: const HomeScreen(),
        );
      },
    );
  }
}

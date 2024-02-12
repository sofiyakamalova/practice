import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:work_with_network/my_home_page.dart';
import 'package:work_with_network/theme_settings.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ThemeSettingsAdapter());
  await Hive.openBox<ThemeSettings>('themeSettings');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ThemeSettings>('themeSettings').listenable(),
      builder: (context, Box<ThemeSettings> box, _) {
        final themeSettings =
            box.get('settings', defaultValue: ThemeSettings(isDarkMode: false));
        return MaterialApp(
          title: 'Theme Switcher',
          theme:
              themeSettings!.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: MyHomePage(),
        );
      },
    );
  }
}

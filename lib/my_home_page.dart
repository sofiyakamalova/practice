import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:work_with_network/offices.dart';

import 'theme_settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<OfficesList> officesList;
  @override
  void initState() {
    officesList = getOfficeslist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Serialization'),
        centerTitle: true,
        actions: [
          SwitchTheme(),
        ],
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.offices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data!.offices[index].name),
                      subtitle: Text(snapshot.data!.offices[index].address),
                      leading: Image.network(
                          '${snapshot.data!.offices[index].image}'),
                      isThreeLine: true,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class SwitchTheme extends StatefulWidget {
  @override
  _SwitchThemeState createState() => _SwitchThemeState();
}

class _SwitchThemeState extends State<SwitchTheme> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isDarkMode,
      onChanged: (value) {
        final themeSettingsBox = Hive.box<ThemeSettings>('themeSettings');
        final themeSettings = ThemeSettings(isDarkMode: value);
        themeSettingsBox.put('settings', themeSettings);
        setState(() {
          isDarkMode = value;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_with_network/offices.dart';
import 'package:work_with_network/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          IconButton(
            icon: const Icon(
              Icons.brightness_6,
              size: 30,
            ),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey
                : Colors.green,
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).swapTheme();
            },
          )
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
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: switchValue,
      onChanged: (newValue) {
        setState(() {
          switchValue = newValue;
        });
      },
    );
  }
}

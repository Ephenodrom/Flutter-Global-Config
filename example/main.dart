import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'AppSettings.config.dart';
import 'DevSettings.config.dart';

void main() async {
  GlobalConfiguration().loadFromMap(appSettings).loadFromMap(devSettings);
  await GlobalConfiguration().loadFromPath("app_setings.json");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    // Access configuration at constructor
    GlobalConfiguration cfg = new GlobalConfiguration();
    print("Key1 has value ${cfg.getString("key1")}");
    print("Key2 has value ${GlobalConfiguration().getString("key2")}");
    print("Key5 has value ${cfg.getString("key5")}, this should be null!");

    //  Added
    print(
        "This is a string deep value ${cfg.getDeepValue<String>("otherValues:moreDeepValues:mySecretValue")}");
    print(
        "This is a color ${cfg.getDeepValue<Color>("appColors:primaryColor")}");
    print("This is a boolean ${cfg.getDeepValue<bool>("booleanValue")}");
  }

  @override
  Widget build(BuildContext context) {
    // Access configuration at build method
    GlobalConfiguration cfg = new GlobalConfiguration();
    print("Key3 has value ${cfg.getString("key3")}");
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

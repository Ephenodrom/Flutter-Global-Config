library global_configuration;

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


///
/// Class for managing different configuration.
/// Use it with new GlobalConfiguration() to access the singleton.
///
class GlobalConfiguration {
  static final GlobalConfiguration _singleton =
  new GlobalConfiguration._internal();

  factory GlobalConfiguration() {
    return _singleton;
  }

  GlobalConfiguration._internal();

  List<Map<String, dynamic>> appConfigs = new List<Map<String, dynamic>>();

  List<Map<String, Map<String, dynamic>>> sharedConfigs =
  new List<Map<String, Map<String, dynamic>>>();

  ///
  /// Loading a configuration map into the current app config.
  ///
  GlobalConfiguration loadFromMap(Map<String, String> config) {
    appConfigs.add(config);
    return _singleton;
  }

  ///
  /// Loading a json configuration file into the current app config.
  ///
  Future<GlobalConfiguration> loadFromAsset(String name) async {
    String content = await rootBundle.loadString("assets/cfg/$name.json");
    Map<String, dynamic> configAsMap = json.decode(content);
    appConfigs.add(configAsMap);
    return _singleton;
  }

  ///
  /// Loading a json configuration file into the current app config.
  ///
  Future<GlobalConfiguration> loadFromSharedPreference(String name) async {
    // TODO
    return _singleton;
  }

  ///
  /// Get the value for the given key from the app config.
  ///
  String getAppConfig(String key) {
    for (Map<String, dynamic> m in appConfigs) {
      if (m.containsKey(key)) {
        return m[key];
      }
    }
    return null;
  }

  ///
  /// Get the value for the given key from the shared config
  ///
  String getSharedConfig(String key) {
    for (Map<String, Map<String, dynamic>> file in sharedConfigs) {
      for (Map<String, dynamic> m in file.values) {
        if (m.containsKey(key)) {
          return m[key];
        }
      }
    }
    return null;
  }
}

library global_configuration;

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:convert';

///
/// Class for managing different configuration.
/// Use it with new GlobalConfiguration() to access the singleton.
///
class GlobalConfiguration {
  static GlobalConfiguration _singleton = new GlobalConfiguration._internal();

  factory GlobalConfiguration() {
    return _singleton;
  }

  GlobalConfiguration._internal();

  Map<String, dynamic> appConfig = Map<String, dynamic>();

  ///
  /// Loading a configuration map into the current app config.
  ///
  GlobalConfiguration loadFromMap(Map<String, dynamic> config) {
    appConfig.addAll(config);
    return _singleton;
  }

  ///
  /// Loading a json configuration file into the current app config.
  ///
  Future<GlobalConfiguration> loadFromAsset(String name) async {
    String content = await rootBundle.loadString("assets/cfg/$name.json");
    Map<String, dynamic> configAsMap = json.decode(content);
    appConfig.addAll(configAsMap);
    return _singleton;
  }

  ///
  /// Loading a configuration file from a url into the current app config.
  ///
  Future<GlobalConfiguration> loadFromUrl(String url,
      {Map<String, String> queryParameters,
        Map<String, String> headers}) async {
    Map<String, dynamic> configAsMap = await _getFromUrl(url,
        queryParameters: queryParameters, headers: headers);
    appConfig.addAll(configAsMap);
    return _singleton;
  }

  /// Reads a value of any type from persistent storage.
  dynamic get(String key) => appConfig[key];

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  bool getBool(String key) => appConfig[key];

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  int getInt(String key) => appConfig[key];

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  double getDouble(String key) => appConfig[key];

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  String getString(String key) => appConfig[key];

  /// Write a value from persistent storage, throwing an exception if it's not
  /// the correct type
  void setValue(key, value) =>
      key.runtimeType != appConfig[key].runtimeType
          ? throw("wrong type")
          : appConfig.update(key, value);

  /// Adds any type to the persistent storage.
  add(Map<String, dynamic> map) => appConfig.addAll(map);

  ///
  /// Sends a HTTP GET request to the given URL with the given PARAMETERS
  ///
  Future<Map<String, dynamic>> _getFromUrl(String url,
      {Map<String, String> queryParameters,
        Map<String, String> headers}) async {
    String finalUrl = url;
    if (queryParameters != null) {
      queryParameters.forEach((k, v) {
        finalUrl += !finalUrl.endsWith("?") ? "?$k=$v" : "&$k=$v";
      });
    }
    if (headers == null) {
      headers = Map<String, String>();
    }
    headers.putIfAbsent("Accept", () => "application/json");
    var response = await http.get(Uri.encodeFull(finalUrl), headers: headers);
    if (response == null || response.statusCode != 200) {
      throw new Exception('HTTP request failed, statusCode: ${response
          ?.statusCode}, $finalUrl');
    }
    return json.decode(response.body);
  }
}

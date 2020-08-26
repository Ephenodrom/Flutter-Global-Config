library global_configuration;

import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:convert';

///
/// Class for managing different configuration.
///
/// Use it with GlobalConfiguration() to access the singleton.
///
class GlobalConfiguration {
  static GlobalConfiguration _singleton = new GlobalConfiguration._internal();

  //  conver string hex color like #AABBCC to Color widget
  Color _hexStringToColor(String code) =>
      new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

  factory GlobalConfiguration() {
    return _singleton;
  }

  GlobalConfiguration._internal();

  Map<String, dynamic> appConfig = Map<String, dynamic>();

  ///
  /// Loading a configuration [map] into the current app config.
  ///
  GlobalConfiguration loadFromMap(Map<String, dynamic> map) {
    appConfig.addAll(map);
    return _singleton;
  }

  ///
  /// Loading a json configuration file with the given [name] into the current app config.
  ///
  /// If the given [name] does not have the file extension .json, it will be automatically added.
  ///
  /// The file has to be placed at assets/cfg/.
  ///
  /// Use the **loadFromPath** method if you want to store the file at another place.
  ///
  Future<GlobalConfiguration> loadFromAsset(String name) async {
    if (!name.endsWith(".json")) {
      name = "$name.json";
    }
    String content = await rootBundle.loadString("assets/cfg/$name");
    Map<String, dynamic> configAsMap = json.decode(content);
    appConfig.addAll(configAsMap);
    return _singleton;
  }

  ///
  /// Loading a json configuration file from a custom [path] into the current app config.
  ///
  Future<GlobalConfiguration> loadFromPath(String path) async {
    String content = await rootBundle.loadString(path);
    Map<String, dynamic> configAsMap = json.decode(content);
    appConfig.addAll(configAsMap);
    return _singleton;
  }

  ///
  /// Loading a json configuration file from a custom [path] into the current app config with the given [key].
  ///
  Future<GlobalConfiguration> loadFromPathIntoKey(
      String path, String key) async {
    String content = await rootBundle.loadString(path);
    Map<String, dynamic> configAsMap = json.decode(content);
    appConfig.putIfAbsent(key, () => configAsMap);
    return _singleton;
  }

  ///
  /// Loading a configuration file from the given [url] into the current app config using
  /// a http GET request to fetch the configuration.
  ///
  /// The request can be modified with [queryParameters] and [headers].
  ///
  Future<GlobalConfiguration> loadFromUrl(String url,
      {Map<String, String> queryParameters,
      Map<String, String> headers}) async {
    Map<String, dynamic> configAsMap = await _getFromUrl(url,
        queryParameters: queryParameters, headers: headers);
    appConfig.addAll(configAsMap);
    return _singleton;
  }

  ///
  /// Loading a configuration file from the given [url] into the current app config with the given [key].
  ///
  /// It uses a http GET request to fetch the configuration.
  /// The request can be modified with [queryParameters] and [headers].
  ///
  Future<GlobalConfiguration> loadFromUrlIntoKey(String url, String key,
      {Map<String, String> queryParameters,
      Map<String, String> headers}) async {
    Map<String, dynamic> configAsMap = await _getFromUrl(url,
        queryParameters: queryParameters, headers: headers);
    appConfig.putIfAbsent(key, () => configAsMap);
    return _singleton;
  }

  ///
  /// Reads a value of any type from persistent storage for the given [key].
  ///
  dynamic get(String key) => appConfig[key];

  ///
  /// Reads a value of T type from persistent storage for the given [key].
  ///
  T getValue<T>(String key) => appConfig[key] as T;

  ///
  /// Reads a value of T type from persistent storage for the given [keyPath]
  /// when [keyPath] is a Json path separated by ':' like 'appColors:primaryColor'
  /// when our Json file is:
  /// {
  ///     "appColors": {
  ///         "primaryColor": "#2e7d32"
  ///     }
  /// }
  ///
  /// You can also use getDeepValue<Color> when the json color value is
  /// an string hexadecimal like "#2e7d32".
  ///
  T getDeepValue<T>(String keyPath) {
    dynamic _value;

    keyPath.split(":").forEach((element) {
      if (_value == null)
        _value = appConfig[element];
      else
        _value = _value[element];
    });

    if (_value != null) {
      if (T == Color) _value = _hexStringToColor(_value);

      return _value as T;
    }

    return null;
  }

  ///
  /// Reads a [bool] value from persistent storage for the given [key], throwing an exception if it's not a bool.
  ///
  @Deprecated("use getValue instead")
  bool getBool(String key) => appConfig[key];

  ///
  /// Reads a [int] value from persistent storage for the given [key], throwing an exception if it's not an int.
  ///
  @Deprecated("use getValue instead")
  int getInt(String key) => appConfig[key];

  ///
  /// Reads a [double] value from persistent storage for the given [key], throwing an exception if it's not a double.
  ///
  @Deprecated("use getValue instead")
  double getDouble(String key) => appConfig[key];

  ///
  /// Reads a [String] value from persistent storage for the given [key], throwing an exception if it's not a String.
  ///
  @Deprecated("use getValue instead")
  String getString(String key) => appConfig[key];

  ///
  /// Clear the persistent storage. Only for Unit testing!
  ///
  void clear() => appConfig.clear();

  /// Write a value from persistent storage, throwing an exception if it's not
  /// the correct type
  @Deprecated("use updateValue instead")
  void setValue(key, value) => value.runtimeType != appConfig[key].runtimeType
      ? throw ("wrong type")
      : appConfig.update(key, (dynamic) => value);

  ///
  /// Update the given [value] for the given [key] in the storage.
  ///
  /// The updated value is *NOT* persistent
  /// Throws an exception if the given [value] has not the same [Type].
  ///
  void updateValue(String key, dynamic value) {
    if (appConfig[key] != null &&
        value.runtimeType != appConfig[key].runtimeType) {
      throw ("The persistent type of ${appConfig[key].runtimeType} does not match the given type ${value.runtimeType}");
    }
    appConfig.update(key, (dynamic) => value);
  }

  ///
  /// Adds the given [value] at the given [key] to the storage.
  ///
  /// The key and value is *NOT* persistent
  ///
  void addValue(String key, dynamic value) =>
      appConfig.putIfAbsent(key, () => value);

  ///
  /// Adds the given [map] to the storage.
  ///
  add(Map<String, dynamic> map) => appConfig.addAll(map);

  ///
  /// Sends a HTTP GET request to the given [url] with the given [queryParameters] and [headers].
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
      throw new Exception(
          'HTTP request failed, statusCode: ${response?.statusCode}, $finalUrl');
    }
    return json.decode(response.body);
  }
}

library global_configuration;

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

  List<Map<String, String>> configs = new List<Map<String, String>>();

  ///
  /// Loading a configuration map into the current config.
  ///
  GlobalConfiguration load(Map<String,String> config) {
    configs.add(config);
    return _singleton;
  }

  ///
  /// Get the value for the given key.
  ///
  String getConfig(String key){
    for(Map<String,String> m in configs){
      if(m.containsKey(key)){
        return m[key];
      }
    }
    return null;
  }
}

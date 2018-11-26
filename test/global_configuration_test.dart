import 'package:flutter_test/flutter_test.dart';

import 'package:global_configuration/global_configuration.dart';

void main() {
  test('Testing get value for key.', () {
    final cfg = GlobalConfiguration();
    final Map<String, String> config1 = {
      "key1": "value1",
      "key2": "value2"
    };

    final Map<String, String> config2 = {
      "key3": "value3",
      "key4": "value4"
    };
    cfg.loadFromMap(config1);
    cfg.loadFromMap(config2);
    expect(cfg.getString("key1"), "value1");
    expect(cfg.getString("key3"), "value3");
  });
}

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
    cfg.load(config1);
    cfg.load(config2);
    expect(cfg.getConfig("key1"), "value1");
    expect(cfg.getConfig("key3"), "value3");
  });
}

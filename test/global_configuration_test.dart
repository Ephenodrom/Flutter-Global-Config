import 'package:flutter_test/flutter_test.dart';

import 'package:global_configuration/global_configuration.dart';

void main() {
  test('Testing get value for key.', () {
    final cfg = GlobalConfiguration();
    final Map<String, String> config1 = {"key1": "value1", "key2": "value2"};

    final Map<String, String> config2 = {"key3": "value3", "key4": "value4"};
    cfg.loadFromMap(config1);
    cfg.loadFromMap(config2);
    expect(cfg.getString("key1"), "value1");
    expect(cfg.getString("key3"), "value3");
  });

  test('Testing loading json into config from url.', () async {
    final cfg = GlobalConfiguration();
    await cfg.loadFromUrl("https://swapi.co/api/people/1");
    expect(cfg.getString("name"), "Luke Skywalker");
  });

  test('Testing setValue().', () async {
    final cfg = GlobalConfiguration();
    final Map<String, dynamic> config1 = {"hello": "world", "foo": 123};
    cfg.loadFromMap(config1);

    cfg.setValue("hello", "world!");
    expect(cfg.getString("hello"), "world!");
    cfg.setValue("foo", 321);
    expect(cfg.getInt("foo"), 321);

    try {
      cfg.setValue("foo", "321");
    } catch (e) {
      expect(cfg.getInt("foo"), 321);
      return;
    }
    fail("Expected Exception!");
  });
}

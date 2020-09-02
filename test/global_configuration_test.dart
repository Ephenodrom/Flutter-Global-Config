import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:global_configuration/global_configuration.dart';

void main() {
  test('Testing get value for key.', () {
    GlobalConfiguration().clear();
    final Map<String, String> config1 = {"key1": "value1", "key2": "value2"};

    final Map<String, String> config2 = {"key3": "value3", "key4": "value4"};
    GlobalConfiguration().loadFromMap(config1);
    GlobalConfiguration().loadFromMap(config2);
    expect(GlobalConfiguration().getString("key1"), "value1");
    expect(GlobalConfiguration().getString("key3"), "value3");
  });

  test('Testing read a deep value', () async {
    GlobalConfiguration().clear();
    final jsonString = '{"values" : { "key1" : "value1", "key2" : "value2" } }';
    Map config1 = json.decode(jsonString);

    GlobalConfiguration().loadFromMap(config1);
    expect(GlobalConfiguration().getDeepValue<String>("values:key2"), "value2");
  });

  test('Testing read a color', () async {
    GlobalConfiguration().clear();
    final jsonString = '{"color" : "#F44336" }';
    Map config1 = json.decode(jsonString);

    GlobalConfiguration().loadFromMap(config1);
    expect(
        GlobalConfiguration().getDeepValue<Color>("color"), Color(0xFFF44336));
  });

  test('Testing updateValue().', () async {
    GlobalConfiguration().clear();
    final Map<String, dynamic> config1 = {"hello": "world", "foo": 123};
    GlobalConfiguration().loadFromMap(config1);

    GlobalConfiguration().updateValue("hello", "world!");
    expect(GlobalConfiguration().getString("hello"), "world!");
    GlobalConfiguration().updateValue("foo", 321);
    expect(GlobalConfiguration().getInt("foo"), 321);

    try {
      GlobalConfiguration().updateValue("foo", "321");
    } catch (e) {
      expect(GlobalConfiguration().getInt("foo"), 321);
      return;
    }
    fail("Expected Exception!");
  });

  test('Testing update null value.', () async {
    GlobalConfiguration().clear();
    final Map<String, dynamic> config1 = {"hello": "world", "foo": null};
    GlobalConfiguration().loadFromMap(config1);

    GlobalConfiguration().updateValue("foo", 321);
    expect(GlobalConfiguration().getInt("foo"), 321);
  });

  test('Testing addValue', () async {
    GlobalConfiguration().clear();
    GlobalConfiguration().addValue("hello", "world");
    expect(GlobalConfiguration().getString("hello"), "world");
  });
}

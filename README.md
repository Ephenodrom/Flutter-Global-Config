# Flutter Global Configuration

A flutter package for managing different configurations by merging them together and making
them available everythere inside the app via a singleton.

## Table of Contents

1. [Preamble](#preamble)
2. [Install](#install)
   * [pubspec.yaml](#pubspec.yaml)
3. [Import](#import)
4. [Loading configuration](#loading-configuration)
   * [Load from asset](#load-from-asset)
   * [Load from path](#load-from-path)
   * [Load from path into key](#load-from-path-into-key)
   * [Load from map inside .dart file](#load-from-map-inside-.dart-file)
   * [Load from url](#load-from-url)
5. [Using the configuration in your app](#using-the-configuration-in-your-app)
6. [Overriding configuration](#overriding-configuration)
7. [Full Example](#full-example)
8. [Changelog](#changelog)
9. [Copyright and license](#copyright-and-license)

## Preamble

This package is also part of the [EZ Flutter Framework](https://ez-flutter.de).

## Install

### pubspec.yaml

Update pubspec.yaml and add the following line to your dependencies.

```yaml
dependencies:
  global_configuration: ^1.6.0
```

## Import

Import the package with :

```dart
import 'package:global_configuration/global_configuration.dart';
```

## Loading configuration

There are many ways where you can store your configuration files and load them.

### Load from asset

#### Creating a configuration file inside assets/cfg folder

Create a .json file and place it under assets/cfg/
Example filename: assets/cfg/app_settings.json

```json
{
  "key1": "value1",
  "key2": "value2"
}
```

Remember to update your pubspec.yaml file, so the config can be loaded from the assets directory!
The config files must be placed under the assets/cfg/ directory.

```yaml
flutter:
 assets:
  - assets/cfg/
```

#### Load configuration from assets at app start

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async{
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  ...
}
```

### Load from path

#### Creating a configuration file anywhere

Create a file anywhere inside your app.

#### Load configuration from path at app start

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main(){
  await GlobalConfiguration().loadFromPath("/path/file.json");
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  ...
}
```

### Load from path into key

The same as loadFromPath, but the config is added under the given key.

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main(){
  await GlobalConfiguration().loadFromPathIntoKey("/path/file.json", "env_settings");
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  ...
}
```

### Load from map

#### Creating a configuration inside .dart file

Create a dart file which includes your configuration and import it in your main file.
Example filename: /config/app_settings.config.dart

```dart
final Map<String, String> appSettings = {
  "key1": "value1",
  "key2": "value2"
};
```

#### Load configuration from map at app start

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'config/app_settings.config.dart';

void main(){
  GlobalConfiguration().loadFromMap(appSettings);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  ...
}
```

### Load from url

It is possible to load any json configuration file from a url. Use the method loadFromUrl to load
the config via GET request.
Please consider using a try / catch. This method will throw an exception if the status code of the
GET request is not 200.

The method also accepts query parameters and headers! The header "Accept: application/json" is always
included.

#### Load configuration from url at app start

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async{
  try{
    await GlobalConfiguration().loadFromUrl("http://urlToMyConfig.com");
  }catch(e){
    // something went wrong while fetching the config from the url ... do something
  }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  ...
}
```

## Using the configuration in your app

Instatiate the GlobalConfiguration class and call any get($key) method.

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class CustomWidget extends StatelessWidget {

    CustomWiget(){
        // Access the config in the constructor
        print(GlobalConfiguration().getString("key1")); // prints value1
    }

    @override
     Widget build(BuildContext context) {
        // Access the config in the build method
        return Text(GlobalConfiguration().getString("key2")); // prints value2
     }
}
```

## Overriding configuration

Sometimes it is necessary to override data in the configuration. This can be done by the updateValue method.
This method makes a check for the given type of the value and then performs an update the configuration map.

```dart
  Map<String, String> appSettings = {
    "key1": "value1",
    "key2": 1
  };
  GlobalConfiguration().loadFromMap(appSettings); // loading the configuration
  print(GlobalConfiguration().getString("key1")); // output : value1
  print(GlobalConfiguration().getString("key2")); // output : 1
  GlobalConfiguration().updateValue("key1", "value2"); // update the value for key1
  GlobalConfiguration().updateValue("key2", 2); // update the value for key2
  print(GlobalConfiguration().getString("key1")); // output : value2
  print(GlobalConfiguration().getString("key2")); // output : 2
```

### Full example

You can find a full example in the [example folder](/example/main.dart).

## Changelog

For a detailed changelog, see the [CHANGELOG.md](CHANGELOG.md) file

## Copyright and license

MIT License

Copyright (c) 2019 Ephenodrom

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

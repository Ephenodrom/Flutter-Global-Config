# Flutter Global Configuration

A flutter package for managing different configurations and making them available everythere inside the app.

## Table of Contents
1. [Install](#install)
   * [pubspec.yaml](#pubspec.yaml)
2. [Loading configuration](#loading-configuration)
   * [Load from asset](#load-from-asset)
   * [Load from shared preferences](#load-from-shared-preferences)
   * [Load from map inside .dart file](#load-from-map-inside-.dart-file)
3. [Using the configuration in your app](#using-the-configuration-in-your-app
4. [Upcoming](#upcoming)
5. [Changelog](#changelog)
6. [Copyright and license](#copyright-and-license)

## Install
### pubspec.yaml

Update pubspec.yaml and add the following line to your dependencies.

```yaml
dependencies:
  global_configuration: ^0.1.1
```


## Loading configuration
There are many ways where you can store your configuration files and load them.
### Load from asset
#### Creating a configuration file
Create a .json file and place it under assets/cfg/
Example filename: assets/cfg/app_settings.json

```json
{
  "key1": "value1",
  "key2": "value2"
}

```
Remember to update your pubspec.yaml file, so the config can be loaded from the assets directory!
```dart
flutter:
 assets:
  - assets/cfg/
```

#### Load configuration at app start

Import the package with : import 'package:global_configuration/global_configuration.dart';

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async{
  GlobalConfiguration cfg = new GlobalConfiguration();
  await cfg.loadFromAsset("app_settings");
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  ...
}

```

### Load from shared preferences
!!! TODO !!!

### Load from map inside .dart file

#### Creating a configuration file
Create a dart file which includes your configuration and import it in your main file.
Example filename: /config/app_settings.config.dart

```dart
final Map<String, String> appSettings = {
  "key1": "value1",
  "key2": "value2"
};

```

#### Load configuration at app start

Import the package with : import 'package:global_configuration/global_configuration.dart';

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'config/Config1.config.dart';

void main(){
  GlobalConfiguration cfg = new GlobalConfiguration();
  cfg.load(appSettings);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  ...
}

```

## Using the configuration in your app
Instatiate the GlobalConfiguration class and call the getAppConfig($key) or getSharedConfig($key) method.

```dart
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class CustomWidget extends StatelessWidget {

    CustomWiget(){
        // Access the config in the constructor
        GlobalConfiguration cfg = new GlobalConfiguration();
        print(cfg.getConfig("key1"); // prints value1
    }

    @override
     Widget build(BuildContext context) {
        // Access the config in the build method
        GlobalConfiguration cfg = new GlobalConfiguration();
        return new Text(cfg.getConfig("key2"));
     }
}

```
### Simple example
You can find a full example in the [example folder](/example/main.dart).

## Upcoming
Here is a list of possible upcoming features
* Update config in shared preferences
* Allow multiple keys with the same name


## Changelog
### Version 0.0.1 (2018-11-25)
- Initial release
### Version 0.0.2 (2018-11-25)
- Fill README.md with content and examples
### Version 0.1.0 (2018-11-25)
- Add example folder
### Version 0.1.0 (2018-11-25)
- Add loading file from asset folder

## Copyright and license
MIT License

Copyright (c) 2018 Ephenodrom

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

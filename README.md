# global_configuration

A flutter package for managing different configurations and making them available everythere inside the app.

## Table of Contents
1. [Install](#install)
   * [pubspec.yaml](#pubspec.yaml)
2. [Usage](#usage)
3. [Upcoming](#upcoming)
4. [Changelog](#changelog)
5. [Copyright and license](#copyright-and-license)

## Install
### pubspec.yaml

Update pubspec.yaml and add the following line to your dependencies.

```yaml
dependencies:
...yaml
  global_configuration: ^0.0.1
```


##Usage
### Creating a configuration file
Create a dart file which includes your configuration and import it in your main file.
Example filename: /config/app_settings.config.dart

```dart
final Map<String, String> appSettings = {
  "key1": "value1",
  "key2": "value2"
};

```

### Load configuration at app start

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

### Use configuration in your app
Now instatiate the GlobalConfiguration class and call the getConfig($key) method.
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

## Upcoming
Here is a list of planned features
* Load config from file
* Load config from shared preferences
* Update config in shared preferences


## Changelog
### Version 0.0.1 (2018-11-25)
- Initial release
### Version 0.0.2 (2018-11-25)
- Fill README.md with content and examples
### Version 0.1.0 (2018-11-25)
- Add example folder

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

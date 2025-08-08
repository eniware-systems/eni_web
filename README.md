# eni_web - Eniware Web

The 'eni_web' package provides a simple solution for web embedding functionality. 

## Features

- **WebInterop**: Exposes JavaScript [Event]s from the embedding page via a broadcast [Stream].
- **Scroll Event Suppression**: Includes a widget that blocks external scroll behavior from the embedded web page.
- **Send Web Events**: Supports the following events: 
  - Size Change
  - Scroll to End of Page
  - Fullscreen


## Getting Started
To begin using `eni_web` in your project, install the package via:
```bash
dart pub add eni_web
```

### Basic Setup

To use eni_web in your Flutter application, it's recommended to set up the `ServiceScope` and use addWebIntegration:

```dart
import 'package:eni_web/eni_web.dart';
import 'package:eni_svc/eni_svc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ServiceScope(child: const MyApp())
      ..addWebIntegration()
  );
}
```

## Usage

### ScrollableRegion
Use the [ScrollableRegion] widget in your Flutter widget tree to block scroll events from the embedded web page.

### Send Event
To send a supported Event, use the [sendAppEvent] method.
For [SizeChangeEvent], it is recommended to call it inside the dispose method of the StatefulWidget of your App Body class.
For [FullscreenEvent], invoke it within a WidgetsBinding.instance.addPostFrameCallback.

### WebInteropService
To listen for web events via a broadcast [Stream], get the service and attach your listener as follows:

```dart
final webInteropService = context.getServiceOrNull<WebInteropService>();

StreamSubscription<Event>? subscription = webInteropService.jsEvents.listen(_yourFunction);
```
Use a method which accepts an Event from dart:html:
```dart
void _yourFunction(Event event) {
  // your code here 
}
```

## License

This package is proprietary software owned by [Eniware Systems GmbH](https://eniware-systems.de). All rights reserved.

Unauthorized reproduction or distribution of this package, or any portion of it, may result in severe civil and criminal penalties, and will be prosecuted to the maximum extent possible under the law.

For licensing inquiries or other questions, please contact [info@eniware-systems.de](mailto:info@eniware-systems.de)

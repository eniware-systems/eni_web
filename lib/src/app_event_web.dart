// ignore: deprecated_member_use
import 'package:js/js.dart';

// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:js_util' as js;

import 'app_event.dart';

@JS("onAppEvent")
external _onAppEvent(Object event);

Object _toJS(dynamic v) {
  if (v is Map<String, dynamic>) {
    var object = js.newObject();
    v.forEach((k, v) {
      var key = k;
      var value = _toJS(v);
      js.setProperty(object, key, value);
    });
    return object;
  }

  return v;
}

/// Method to send Event to Web Page
void sendAppEvent(AppEvent event) {
  _onAppEvent(_toJS(event.toJson()));
}

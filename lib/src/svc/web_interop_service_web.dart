import 'dart:async';

// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html';

import 'package:eni_svc/eni_svc.dart';
import 'package:eni_utils/eni_utils.dart';
import 'package:js/js.dart';

@JS('eniHandleEvent')
external set _eniHandleEvent(void Function(Event event) f);

/// A service that exposes JavaScript [Event]s from embedding pages via a
/// broadcast [Stream].
class WebInteropService with Service {
  final _jsEventStream = StreamController<Event>.broadcast(sync: true);
  final _logger = loggerFor("WebInteropService");

  /// A [Stream] that broadcasts JavaScript [Events]s synchronously.
  Stream<Event> get jsEvents => _jsEventStream.stream;

  @override
  Future onPreInit(ServiceRegistry services) async {
    _eniHandleEvent = allowInterop(_jsEventStream.add);

    _logger.i("Web Embedding support enabled");
  }
}

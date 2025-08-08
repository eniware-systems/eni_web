import 'dart:async';
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html';

import 'package:eni_svc/eni_svc.dart';
import 'package:eni_utils/eni_utils.dart';
import 'package:eni_web/src/svc/web_interop_service_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A [ScrollableRegion] is a web-only widget that can block the external scroll
/// behavior of the embedded web page.
///
class ScrollableRegion extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const ScrollableRegion({super.key, required this.child, this.enabled = true});

  @override
  State<ScrollableRegion> createState() => _ScrollableRegionState();
}

class _ScrollableRegionState extends State<ScrollableRegion> {
  StreamSubscription<Event>? _subscription;

  final _logger = loggerFor("ScrollableRegion");

  @override
  void dispose() {
    if (_subscription != null) {
      _logger.d("ScrollableRegion is not blocking wheel events anymore");
      _subscription?.cancel();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ScrollableRegion oldWidget) {
    if (oldWidget.enabled != widget.enabled) {
      _subscription?.cancel();
      _subscription = null;

      if (widget.enabled) {
        _blockScrolling();
      } else {
        _logger.d("ScrollableRegion is not blocking wheel events anymore");
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleJSEvent(Event event) {
    if (!context.mounted) {
      return;
    }

    if (event is WheelEvent) {
      // Wheel event, check if the mouse is currently over this widget.
      final mousePosition = event.offset;
      final box = context.findRenderObject() as RenderBox?;

      if (box != null) {
        final worldPos = box.localToGlobal(Offset.zero);
        final bounds = box.paintBounds;

        if (worldPos.dx <= mousePosition.x &&
            worldPos.dy <= mousePosition.y &&
            worldPos.dx + bounds.width > mousePosition.x &&
            worldPos.dy + bounds.height >= mousePosition.y) {
          // Mouse is over the widget, prevent the propagation of the event
          event.stopImmediatePropagation();
          event.preventDefault();
        }
      }
    }
  }

  void _blockScrolling() {
    _logger.d("ScrollableRegion is blocking wheel events");
    final webInteropService = context.getServiceOrNull<WebInteropService>();

    if (webInteropService == null) {
      _logger.w(
          "WebInteropService not found, ScrollableRegion will not block scroll events");
      return;
    }

    _subscription = webInteropService.jsEvents.listen(_handleJSEvent);
  }

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _blockScrolling();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

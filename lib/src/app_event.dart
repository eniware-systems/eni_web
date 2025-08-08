import 'dart:ui';

export './app_event_unsupported.dart'
    if (dart.library.js) './app_event_web.dart';

abstract class AppEvent {
  Map<String, dynamic> toJson();
}

/// [Event] to scroll to the end of the page
class ScrollToEvent extends AppEvent {
  final double offset;

  ScrollToEvent([this.offset = 0]);

  @override
  Map<String, dynamic> toJson() => {"type": "scroll_to", "offset": offset};
}

/// [Event] to trigger a size change
class SizeChangeEvent extends AppEvent {
  final Size newSize;

  SizeChangeEvent(this.newSize);

  @override
  Map<String, dynamic> toJson() =>
      {"type": "size_change", "width": newSize.width, "height": newSize.height};
}

/// [Event] to toggle fullscreen mode
class FullscreenEvent extends AppEvent {
  final bool enabled;

  FullscreenEvent([this.enabled = true]);

  @override
  Map<String, dynamic> toJson() => {"type": "fullscreen", "enabled": enabled};
}

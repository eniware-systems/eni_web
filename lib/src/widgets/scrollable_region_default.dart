import 'package:flutter/widgets.dart';

/// A [ScrollableRegion] is a web-only widget that can block the external scroll
/// behavior of the embedded web page. In a non-web environment it has no effect.
///
class ScrollableRegion extends StatelessWidget {
  final Widget child;

  const ScrollableRegion({super.key, required this.child, bool enabled = true});

  @override
  Widget build(BuildContext context) => child;
}

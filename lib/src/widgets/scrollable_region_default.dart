import 'package:flutter/widgets.dart';

class ScrollableRegion extends StatelessWidget {
  final Widget child;

  const ScrollableRegion({super.key, required this.child, bool enabled = true});

  @override
  Widget build(BuildContext context) => child;
}

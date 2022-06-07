import 'package:flutter/material.dart';

class WidthConstrainedBox extends StatelessWidget {
  const WidthConstrainedBox({
    required this.child,
    this.maxWidth = 500,
    this.minWidth = 200,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double maxWidth;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, minWidth: minWidth),
        child: Row(
          children: [
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

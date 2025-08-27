import 'package:flutter/material.dart';
import 'package:pg_web/presentation/widgets/loading_indicator.dart';

class GrayedOut extends StatelessWidget {
  final Widget child;
  final bool grayedOut;
  final bool showLoading;
  final double opacity;

  const GrayedOut({
    super.key,
    required this.child,
    this.grayedOut = true,
    this.showLoading = false,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return grayedOut
        ? Stack(
            children: <Widget>[
              Opacity(
                opacity: opacity,
                child: IgnorePointer(child: child),
              ),
              if (showLoading) const Center(child: LoadingIndicatorWidget()),
            ],
          )
        : child;
  }
}

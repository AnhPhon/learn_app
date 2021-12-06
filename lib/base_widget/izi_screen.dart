import 'package:flutter/material.dart';
import 'package:template/base_widget/background/background_one.dart';

class IZIScreen extends StatelessWidget {
  const IZIScreen({
    Key? key,
    required this.child,
    this.background,
  }) : super(key: key);
  final Widget child;
  final Widget? background;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          background ?? const BackgroundOne(),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: child,
            ),
          ),
        ],
      ),
    );
  }
}

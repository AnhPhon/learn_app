import 'package:flutter/material.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/helper/izi_size.dart';

class IZIScreen extends StatelessWidget {
  const IZIScreen({
    Key? key,
    required this.body,
    this.background,
    this.appBar,
  }) : super(key: key);
  final Widget body;
  final Widget? background;
  final Widget? appBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          background ?? const BackgroundOne(),
          SafeArea(
            child: LayoutBuilder(builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) {
              IZISize.update(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              );
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    appBar ?? const SizedBox(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: body,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

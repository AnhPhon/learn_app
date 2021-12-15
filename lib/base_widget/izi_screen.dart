import 'package:flutter/material.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/utils/color_resources.dart';

class IZIScreen extends StatelessWidget {
  const IZIScreen({
    Key? key,
    required this.body,
    this.background,
    this.appBar,
    this.isSingleChildScrollView = true,
    this.tabBar,
    this.widgetBottomSheet,
  }) : super(key: key);
  final Widget body;
  final Widget? background;
  final Widget? appBar;
  final Widget? tabBar;
  final Widget? widgetBottomSheet;
  final bool? isSingleChildScrollView;

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
                    if (isSingleChildScrollView!)
                      Expanded(
                        //TODO: Thêm optional cho SingleScrollView
                        child: SingleChildScrollView(
                          child: body,
                        ),
                      )
                    else
                      Expanded(
                        child: body,
                      ),
                  ],
                ),
                bottomSheet: widgetBottomSheet ?? const SizedBox(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

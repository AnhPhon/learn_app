import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/utils/dimensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailWork extends StatelessWidget {
  final String detailWork;
  const DetailWork({Key? key, required this.detailWork}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Html(
        data: CommonHelper().htmlUnescape(detailWork),
        style: {
          "html": Style(textAlign: TextAlign.justify),
          "table": Style(
            backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
          ),
          "tr": Style(
            border: const Border(bottom: BorderSide(color: Colors.grey)),
          ),
          "th": Style(
            padding: const EdgeInsets.all(6),
            backgroundColor: Colors.grey,
          ),
          "td": Style(
            padding: const EdgeInsets.all(6),
            alignment: Alignment.topLeft,
          ),
          'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
        },
        customRender: {
          "table": (context, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: (context.tree as TableLayoutElement).toWidget(context),
            );
          },
          "bird": (RenderContext context, Widget child) {
            return const TextSpan(text: "🐦");
          },
          "flutter": (RenderContext context, Widget child) {
            return FlutterLogo(
              style: (context.tree.element!.attributes['horizontal'] != null)
                  ? FlutterLogoStyle.horizontal
                  : FlutterLogoStyle.markOnly,
              textColor: context.style.color!,
              size: context.style.fontSize!.size! * 5,
            );
          },
        },
      ),
    );
  }
}

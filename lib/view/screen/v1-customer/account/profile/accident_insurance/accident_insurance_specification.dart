import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:template/utils/dimensions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart';

class AccidentInsuranceSpecification extends StatelessWidget {
  final String accidentInsuranceSpecification;
  const AccidentInsuranceSpecification({Key? key, required this.accidentInsuranceSpecification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Html(
          data: _parseHtmlString(accidentInsuranceSpecification),
          style: {
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
          onLinkTap: (url, _, __, ___) {
            print("Opening $url...");
          },
          onImageTap: (src, _, __, ___) {
            print(src);
          },
          onImageError: (exception, stackTrace) {
            print(exception);
          },
          onCssParseError: (css, messages) {
            print("css that errored: $css");
            print("error messages:");
            for (final element in messages) {
              print(element);
            }
          },
        ),
      ),
    );
  }

  ///
  ///  parse Html String
  ///
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}

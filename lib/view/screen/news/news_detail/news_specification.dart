import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsSpecification extends StatelessWidget {
  final String newsSpecification;
  const NewsSpecification({Key? key, required this.newsSpecification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Html(data: newsSpecification);
  }
}

import 'package:html/parser.dart';

class FormatHtmlNotification{
  static String formatHtml({required String content}){
    return parse(parse(content).body!.text).documentElement!.text;
  }
}
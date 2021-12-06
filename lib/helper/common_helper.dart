import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonHelper {
  ///
  ///  A Dart library for unescaping HTML-encoded strings.
  ///
  String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
    
  }

  // String convert

  static Future openLink({required String url})async{
    if(await canLaunch(url)){
      await launch(url);
    }
  }
}

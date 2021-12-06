import 'package:html_unescape/html_unescape.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:url_launcher/url_launcher.dart';

class IZIOther{
  
  ///
  /// open link url
  ///
  static Future openLink({required String url})async{
   if(!IZIValidate.nullOrEmpty(url)){
      if(await canLaunch(url)){
        await launch(url);
      }
    }
  }

}

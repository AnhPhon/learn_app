

class StringCut{
  static String stringCut50(String text){
    String content = text;
    if(text.length > 50){
      content = '${text.substring(0,50)}...';
      return content;
    }
    return content;
  }
  static String stringCut90(String text){
    String content = text;
    if(text.length > 90){
      content = '${text.substring(0,90)}...';
      return content;
    }
    return content;
  }
  static String stringCut120(String text){
    String content = text;
    if(text.length > 120){
      content = '${text.substring(0,120)}...';
      return content;
    }
    return content;
  }
  static String stringCut300(String text){
    String content = text;
    if(text.length > 300){
      content = '${text.substring(0,300)}...';
      return content;
    }
    return content;
  }

}





class Validate{

    final RegExp reg = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    static bool oneUpperCase(String text){
      final RegExp reg = RegExp(r'^(?=.*?[A-Z])\w+$');
      if(reg.hasMatch(text)){
        // có it nhất 1 chữ hoà
        return true;
      }else{
        // không có
        return false;
      }
    }
    ///
    /// Validate lower 
    ///
    static bool oneLowerCase(String text){
      //(?=.*?[a-z])
      
      print(text);
      final RegExp reg = RegExp(r'(?=.*[a-z])\w+$');
      if(reg.hasMatch(text)){
        // có it nhất 1 chữ thường
        return true;
      }else{
        // không có
        return false;
      }
    }

    ///
    ///Validate number
    ///
    static bool leastOneDigit(String text){
      final RegExp reg = RegExp(r'^(?=.*?[0-9])\w+$');
      if(reg.hasMatch(text)){
        // it nhất 1 số
        return true;
      }else{
        // không có
        return false;
      }
    }
    ///
    /// validate special character
    ///
    static bool specialCharacter(String text){
      final RegExp reg = RegExp(r'^(?=.*?[!@#\$&*~])$');
      if(reg.hasMatch(text)){
        // it nhất 1 số
        return true;
      }else{
        // không có
        return false;
      }
    }
    ///
    /// validate Must be at least 8 characters in length  
    ///
    static bool charactersLength(String text){
      final RegExp reg = RegExp(r'^.{8,}$');
      if(reg.hasMatch(text)){
        // it nhất 1 số
        return true;
      }else{
        // không có
        return false;
      }
    }
    ///
    /// Validate email
    ///
    static bool email(String text){
      // a-zA-Z0-9 : cho phep a - Z 0 -9 
      // + @(Bắt buộc )
      final RegExp reg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if(reg.hasMatch(text)){
        // email hợp lệ
        return true;
      }else{
        // không hợp lệ
        return false;
      }
    }
    ///
    /// Validate phone
    ///
    static bool phone(String text){
      //r'^([+0]9)?[0-9]{10}$'
      final RegExp reg = RegExp(r'^([+0])\d{9}$');
      if(reg.hasMatch(text)){
        // email hợp lệ
        return true;
      }else{
        // phone không hợp lệ
        return false;
      }
    }

}
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_binding.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_page.dart';
import 'package:template/view/screen/auth/login/login_binding.dart';
import 'package:template/view/screen/auth/login/login_page.dart';
import 'package:template/view/screen/auth/signup/signup_binding.dart';
import 'package:template/view/screen/auth/signup/signup_page.dart';
import 'package:template/view/screen/auth/update_password/update_password_binding.dart';
import 'package:template/view/screen/auth/update_password/update_password_page.dart';
import 'package:template/view/screen/auth/verify/verify_binding.dart';
import 'package:template/view/screen/auth/verify/verify_page.dart';

class AuthRoutes {
  static const String LOGIN = '/login';
  static const String SIGN_UP = '/sign_up';
  static const String VERIFY = '/verify';
  static const String FORGET_PASSWORD = '/forget_password';
  static const String UPDATE_PASSWORD = '/update_password';

  static List<GetPage> list = [
    GetPage(
      name: LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
      name: SIGN_UP,
      page: () => SignUpPage(),
      binding: SignUpBinding()
    ),
    GetPage(
      name: VERIFY,
      page: () => VerifyPage(),
      binding: VerifyBinding()
    ),
    GetPage(
      name: FORGET_PASSWORD,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordBinding()
    ),
    GetPage(
      name: UPDATE_PASSWORD,
      page: () => UpdatePasswordPage(),
      binding: UpdatePasswordBinding()
    ),
  ];
}

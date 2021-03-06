//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:template/app_binding.dart';
import 'package:template/data/model/provider/provider.dart';
import 'package:template/data/model/san_pham/product_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/localization/app_localization.dart';
import 'package:template/routes/app_pages.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:timeago/timeago.dart' as timeago;

import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  timeago.setLocaleMessages('vi', timeago.ViMessages());

  // init dependence injection
  await di.init();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  Provider provider = Provider();
  provider.all(
    UserResponse,
    onSuccess: (data) {},
    onError: (error) {},
  );
  provider.paginate(
    ProductResponse,
    filter: '',
    limit: 1,
    page: 1,
    onSuccess: (data) {},
    onError: (error) {},
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final List<Locale> _locals = [];

    // add all LanguageModel from app_constants
    for (int i = 0; i < app_constants.languages.length; i++) {
      _locals.add(Locale(app_constants.languages[i].languageCode.toString(), app_constants.languages[i].countryCode));
    }
    Locale localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
      if (locale == null) {
        return supportedLocales.first;
      }
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    }

    return GetMaterialApp(
      initialRoute: SplashRoutes.SPLASH,
      initialBinding: AppBinding(),
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      supportedLocales: _locals,
      localizationsDelegates: const [
        AppLocalization.delegate, // Load d?? li???u tr?????c
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: EasyLoading.init(),
      localeResolutionCallback: localeResolutionCallback,
      // darkTheme: AppTheme.dark,
      // themeMode: ThemeMode.system,
      // locale: ,
      // supportedLocales: _locals,
    );
  }
}

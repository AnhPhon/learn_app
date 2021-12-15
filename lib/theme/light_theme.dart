import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Nutito',
  primaryColor: const Color(0xFF0DAC43),
  brightness: Brightness.light,
  // scaffoldBackgroundColor: ColorResources.BACKGROUND,
  hintColor: const Color(0xFF9E9E9E),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
  ),
);

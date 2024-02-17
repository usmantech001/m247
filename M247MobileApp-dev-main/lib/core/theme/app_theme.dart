// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masjid/core/theme/app_color.dart';

class AppTheme {
  AppTheme._();

  static const SFProFont = "SFPro";
  static const QueenFont = 'QueenFont';
  static const QueenBoldFont = "QueenFontBold";

  static final themeData = ThemeData(
    canvasColor: AppColor.backgroundColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.backgroundColor,
    dialogBackgroundColor: AppColor.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true, // this will remove the default content padding
      // now you can customize it here or add padding widget
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      filled: true,
      fillColor: AppColor.greyBorderColor,
      hintStyle: TextStyle(
        fontFamily: 'SFPro',
        fontSize: 15.sp,
        color: AppColor.greyTextColor,
        fontWeight: FontWeight.w400,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColor.greyBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColor.greyBorderColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColor.greyBorderColor),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColor.backgroundColor,
      textStyle: TextStyle(
        fontSize: 17.sp,
        color: Colors.black,
        fontFamily: AppTheme.SFProFont,
        fontWeight: FontWeight.w400,
        height: 0.08,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}

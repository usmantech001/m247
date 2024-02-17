import 'package:flutter/material.dart';
import 'package:masjid/core/theme/app_theme.dart';
import 'package:masjid/core/exports.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? error;
  const CustomErrorWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Text(
      error!,
      style: TextStyle(
        fontSize: 22.sp,
        color: AppColor.brownColor,
        fontWeight: FontWeight.w600,
        fontFamily: AppTheme.SFProFont,
      ),
    );
  }
}

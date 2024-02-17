import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';

class SvgButton extends StatelessWidget {
  final String? icon;
  final VoidCallback? onPressed;
  const SvgButton({
    super.key,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.greyBorderColor, width: 1),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: SvgPicture.asset(
              icon!,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}

class SvgTextButton extends StatelessWidget {
  final String? icon;
  final String? text;
  final VoidCallback? onPressed;
  const SvgTextButton({
    super.key,
    this.icon,
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.greyBorderColor, width: 1),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon!,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(width: 8.w),
                Text(
                  text!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.brownColor,
                    fontWeight: FontWeight.w700,
                    height: 14.0.toFigmaHeight(20),
                    fontVariations: const [
                      FontVariation('wght', 700),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';

class TimetableInitialWidget extends StatelessWidget {
  const TimetableInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedShimmer(
      width: 374.w,
      height: 70.h,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(5),
      ),
    );
  }
}

class TimetableFailedWidget extends StatelessWidget {
  const TimetableFailedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedShimmer(
      width: 374.w,
      height: 70.h,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(5),
      ),
    );
  }
}

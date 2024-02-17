import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MasjidInitialWidget extends StatelessWidget {
  const MasjidInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SizedBox(
        height: 300.h,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

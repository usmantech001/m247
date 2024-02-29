import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masjid/core/exceptions/network_exception.dart';

class CustomErrorWidget extends StatelessWidget {
  final dynamic error;
  const CustomErrorWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: error is NetworkException ? Text(error!.message) : Text(error),
      ),
    );
  }
}

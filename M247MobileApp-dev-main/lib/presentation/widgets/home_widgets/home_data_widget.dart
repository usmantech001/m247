import 'package:flutter/material.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masjid/presentation/widgets/home_widgets/masjid_tile.dart';

class HomeDataWidget extends StatelessWidget {
  final List<MasjidModel> data;
  final PageController controller;
  final DateTime dateTime;
  const HomeDataWidget(
      {super.key,
      required this.data,
      required this.controller,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final snapshot = data[index];
        return MasjidTile(
          masjid: snapshot,
          dateTime: dateTime,
          controller: controller,
        );
      },
    );
  }
}

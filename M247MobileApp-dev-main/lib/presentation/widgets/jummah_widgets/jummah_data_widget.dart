import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:masjid/data/models/jummah_model.dart';
import 'package:masjid/presentation/widgets/timechecker/timechecker.dart';

class JummahDataWidget extends StatelessWidget {
  final List<JummahModel> data;
  const JummahDataWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: data.isEmpty
          ? const _JummahEmptyWidget()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (_, index) {
                return _JummahTile(snapshot: data[index]);
              },
            ),
    );
  }
}

class _JummahEmptyWidget extends StatelessWidget {
  const _JummahEmptyWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: const Center(
        child: Text(
          "Design Jummah Empty Widget",
        ),
      ),
    );
  }
}

class _JummahTile extends StatelessWidget {
  final JummahModel? snapshot;

  const _JummahTile({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        border: Border(
            bottom: BorderSide(
          color: AppColor.greyBorderColor,
        )),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                snapshot!.name!,
                style: TextStyle(
                  fontFamily: 'SFPro',
                  fontSize: 16.sp,
                  color: AppColor.brownColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    snapshot!.jummah1 ?? "",
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 22.sp,
                      color: AppColor.brownColor,
                      height: 22.0.toFigmaHeight(24),
                      fontVariations: const [
                        FontVariation('wght', 590),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    snapshot!.jummah1!.isEmpty ? '' : "PM",
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 11.sp,
                      color: AppColor.lightGreyColor3,
                      fontWeight: FontWeight.w700,
                      height: 11.0.toFigmaHeight(20),
                      fontVariations: const [
                        FontVariation('wght', 700),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    checkTheNumberOfJummuah(
                        jummah1: snapshot!.jummah2 ?? '',
                        jummah2: snapshot!.jummah3 ?? '',
                        jummah3: snapshot!.jummah4 ?? '',
                        jummah4: ''),
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 22.sp,
                      color: AppColor.brownColor,
                      height: 22.0.toFigmaHeight(24),
                      fontVariations: const [
                        FontVariation('wght', 590),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    snapshot!.jummah2!.isEmpty ? '' : "PM",
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 11.sp,
                      color: AppColor.lightGreyColor3,
                      height: 11.0.toFigmaHeight(20),
                      fontVariations: const [
                        FontVariation('wght', 700),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

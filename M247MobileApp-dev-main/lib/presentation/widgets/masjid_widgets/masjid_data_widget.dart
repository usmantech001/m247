import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:masjid/data/models/timetable_model.dart';
import 'package:masjid/presentation/widgets/timechecker/timechecker.dart';

class MasjidDataWidget extends StatefulWidget {
  final TimetableModel snapshot;
  final PageController pagecontroller;
  const MasjidDataWidget(
      {super.key, required this.snapshot, required this.pagecontroller});

  @override
  State<MasjidDataWidget> createState() => _MasjidDataWidgetState();
}

class _MasjidDataWidgetState extends State<MasjidDataWidget> {
  @override
  void initState() {
    super.initState();
    checkIfEshaHasEnd(
      pageController: widget.pagecontroller,
      startTime: '${widget.snapshot.begEsha} PM',
      endTime: '${widget.snapshot.jamEsha} PM',
      eshaEndTime: '${widget.snapshot.jamEsha} PM',
    );
  }

  @override
  Widget build(BuildContext context) {
    String pm = 'PM';
    String am = 'AM';

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        children: [
          _EventTile(
            startAMPM: widget.snapshot.begFajr!.isEmpty ? '' : am,
            endAMPM: widget.snapshot.jamFajr!.isEmpty ? '' : am,
            name: "Fajr",
            selected: widget.snapshot.begFajr!.isEmpty ||
                    widget.snapshot.jamFajr!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.begFajr} $am',
                    endTime: '${widget.snapshot.jamFajr} $am',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.jamFajr,
            startTime: widget.snapshot.begFajr,
          ),
          _EventTile(
            name: "Sunrise",
            startAMPM: widget.snapshot.sunset!.isEmpty ? '' : am,
            endAMPM: widget.snapshot.sunrise!.isEmpty ? '' : am,
            selected: widget.snapshot.sunrise!.isEmpty ||
                    widget.snapshot.sunset!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.sunset} $am',
                    endTime: '${widget.snapshot.sunrise} $am',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.sunrise,
            startTime: widget.snapshot.sunset,
          ),
          _EventTile(
            name: "Dhuhr",
            startAMPM: widget.snapshot.begDhuhr!.isEmpty ? '' : pm,
            endAMPM: widget.snapshot.jamDhuhr!.isEmpty ? '' : pm,
            selected: widget.snapshot.begDhuhr!.isEmpty ||
                    widget.snapshot.jamDhuhr!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.begDhuhr} $pm',
                    endTime: '${widget.snapshot.jamDhuhr} $pm',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.jamDhuhr,
            startTime: widget.snapshot.begDhuhr,
          ),
          _EventTile(
            name: "Asr",
            startAMPM: widget.snapshot.begAsar!.isEmpty ? '' : pm,
            endAMPM: widget.snapshot.jamAsar!.isEmpty ? '' : pm,
            selected: widget.snapshot.begAsar!.isEmpty ||
                    widget.snapshot.jamAsar!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.begAsar} $pm',
                    endTime: '${widget.snapshot.jamAsar} $pm',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.jamAsar,
            startTime: widget.snapshot.begAsar,
          ),
          _EventTile(
            name: "Maghrib",
            startAMPM: widget.snapshot.sunset!.isEmpty ? '' : pm,
            endAMPM: widget.snapshot.jamMaghrib!.isEmpty ? '' : pm,
            selected: widget.snapshot.sunset!.isEmpty ||
                    widget.snapshot.jamMaghrib!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.sunset} $pm',
                    endTime: '${widget.snapshot.jamMaghrib} $pm',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.jamMaghrib,
            startTime: widget.snapshot.sunset,
          ),
          _EventTile(
            name: "Isha",
            startAMPM: widget.snapshot.begEsha!.isEmpty ? '' : pm,
            endAMPM: widget.snapshot.jamEsha!.isEmpty ? '' : pm,
            selected: widget.snapshot.begEsha!.isEmpty ||
                    widget.snapshot.jamEsha!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.begEsha} $pm',
                    endTime: '${widget.snapshot.jamEsha} $pm',
                    eshaEndTime: '${widget.snapshot.jamEsha} $pm',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.jamEsha,
            startTime: widget.snapshot.begEsha,
          ),
          _EventTile(
            name: "Jumma",
            startAMPM: widget.snapshot.jummah1!.isEmpty ? '' : pm,
            endAMPM: widget.snapshot.jummah2!.isEmpty ? '' : pm,
            selected: widget.snapshot.jummah2!.isEmpty ||
                    widget.snapshot.jummah2!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.jummah2} $pm',
                    endTime: '${widget.snapshot.jummah1} $pm',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.jummah2,
            startTime: widget.snapshot.jummah1,
          ),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final bool? selected;

  final String? name, startTime, startAMPM, endAMPM, endTime;

  const _EventTile({
    this.endAMPM,
    this.startAMPM,
    this.selected,
    this.name,
    this.startTime,
    this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected! ? AppColor.brownColor : AppColor.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color:
                selected! ? AppColor.backgroundColor : AppColor.greyBorderColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Row(
          children: [
            SizedBox(
              width: 140.w,
              child: Text(
                name!,
                style: TextStyle(
                  fontFamily: 'QueenFont',
                  fontSize: 24.sp,
                  color: selected!
                      ? AppColor.backgroundColor
                      : AppColor.brownColor,
                  height: 24.0.toFigmaHeight(24),
                  // here you use the extension
                  fontVariations: const [
                    FontVariation('wght', 675), // Adjust the weight variation
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 135.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    checkStartTime(startTime ?? ''),
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 22.sp,
                      color: selected!
                          ? AppColor.backgroundColor
                          : AppColor.brownColor,
                      fontWeight: FontWeight.w700,
                      height: 22.0
                          .toFigmaHeight(24), // here you use the extension
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    startAMPM ?? '',
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 11.sp,
                      color: AppColor.lightGreyColor3,
                      fontWeight: FontWeight.w700,
                      height: 11.0
                          .toFigmaHeight(20), // here you use the extension
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    checkEndTime(endTime ?? ''),
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 22.sp,
                      color: selected!
                          ? AppColor.backgroundColor
                          : AppColor.brownColor,
                      fontWeight: FontWeight.w700,
                      height:
                          22.0.toFigmaHeight(24), // here you use the extension
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    endAMPM ?? '',
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 11.sp,
                      color: AppColor.lightGreyColor3,
                      fontWeight: FontWeight.w700,
                      height:
                          11.0.toFigmaHeight(20), // here you use the extension
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

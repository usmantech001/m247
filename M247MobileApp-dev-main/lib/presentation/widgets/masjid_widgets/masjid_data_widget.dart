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
   DateTime now = DateTime.now();

  List<DateTime> get generate {
    final list = List.generate(50, (index) => now.add(Duration(days: index)));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    String pm = 'PM';
    String am = 'AM';
   // print('The current date is ${generate[widget.pagecontroller.page!.toInt()]}');

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        children: [
          _EventTile(
            name: "Sunrise",
            startAMPM: widget.snapshot.sunset!.isEmpty ? '' : am,
            endAMPM: '',
            selected: widget.snapshot.sunrise!.isEmpty ||
                    widget.snapshot.sunset!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.sunset} $am',
                    endTime: '${widget.snapshot.sunrise} $am',
                    pagecontroller: widget.pagecontroller),
            endTime: '',
            startTime: widget.snapshot.sunrise,
          ),
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
          checkIfTodayIsFridayAndJummuhIsNotEmpty(
            dateTime: generate[widget.pagecontroller.page?.toInt()?? 0],
                      jummah: widget.snapshot.jummah1 ?? '') ==
                  true
              ? _EventTile(
                  name: "Jummah 1",
                  startAMPM: '',
                  endAMPM: widget.snapshot.jummah2!.isEmpty ? '' : pm,
                  selected: widget.snapshot.jummah2!.isEmpty ||
                          widget.snapshot.jummah2!.isEmpty
                      ? false
                      : checkPrayerTime(
                          startTime: '${widget.snapshot.jummah1} $pm',
                          endTime: '${widget.snapshot.jummah1} $pm',
                          pagecontroller: widget.pagecontroller),
                  endTime: widget.snapshot.jummah1,
                  startTime: '',
                )
              : _EventTile(
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
          checkIfTodayIsFridayAndJummuhIsNotEmpty(
            dateTime: generate[widget.pagecontroller.page?.toInt()?? 0],
                      jummah: widget.snapshot.jummah2 ?? '') ==
                  true
              ? _EventTile(
                  name: "Jummah 2",
                  startAMPM: '',
                  endAMPM: widget.snapshot.jummah2!.isEmpty ? '' : pm,
                  selected: widget.snapshot.jummah2!.isEmpty ||
                          widget.snapshot.jummah2!.isEmpty
                      ? false
                      : checkPrayerTime(
                          startTime: '${widget.snapshot.jummah1} $pm',
                          endTime: '${widget.snapshot.jummah2} $pm',
                          pagecontroller: widget.pagecontroller),
                  endTime: widget.snapshot.jummah2,
                  startTime: '',
                )
              : Container(),
          checkIfTodayIsFridayAndJummuhIsNotEmpty(
            dateTime: generate[widget.pagecontroller.page?.toInt()?? 0],
                      jummah: widget.snapshot.jummah3 ?? '') ==
                  true
              ? _EventTile(
                  name: "Jummah 3",
                  startAMPM: '',
                  endAMPM: widget.snapshot.jummah2!.isEmpty ? '' : pm,
                  selected: widget.snapshot.jummah2!.isEmpty ||
                          widget.snapshot.jummah2!.isEmpty
                      ? false
                      : checkPrayerTime(
                          startTime: '${widget.snapshot.jummah2} $pm',
                          endTime: '${widget.snapshot.jummah3} $pm',
                          pagecontroller: widget.pagecontroller),
                  endTime: widget.snapshot.jummah3,
                  startTime: '',
                )
              : Container(),
          checkIfTodayIsFridayAndJummuhIsNotEmpty(
            dateTime: generate[widget.pagecontroller.page?.toInt()?? 0],
                      jummah: widget.snapshot.jummah4 ?? '') ==
                  true
              ? _EventTile(
                  name: "Jummah 4",
                  startAMPM: '',
                  endAMPM: widget.snapshot.jummah2!.isEmpty ? '' : pm,
                  selected: widget.snapshot.jummah2!.isEmpty ||
                          widget.snapshot.jummah2!.isEmpty
                      ? false
                      : checkPrayerTime(
                          startTime: '${widget.snapshot.jummah3} $pm',
                          endTime: '${widget.snapshot.jummah4} $pm',
                          pagecontroller: widget.pagecontroller),
                  endTime: widget.snapshot.jummah4,
                  startTime: '',
                )
              : Container(),
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
            startAMPM: '',
            endAMPM: widget.snapshot.jamMaghrib!.isEmpty ? '' : pm,
            selected: widget.snapshot.sunset!.isEmpty ||
                    widget.snapshot.jamMaghrib!.isEmpty
                ? false
                : checkPrayerTime(
                    startTime: '${widget.snapshot.sunset} $pm',
                    endTime: '${widget.snapshot.jamMaghrib} $pm',
                    pagecontroller: widget.pagecontroller),
            endTime: widget.snapshot.jamMaghrib,
            startTime: '',
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
          SizedBox(height: 19.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Center(
              child: Text(
                widget.snapshot.freeText ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w400,
                  color: AppColor.greyTextColor,
                ),
              ),
            ),
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
                      height:
                          22.0.toFigmaHeight(24), // here you use the extension
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
                      height:
                          11.0.toFigmaHeight(20), // here you use the extension
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

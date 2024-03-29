import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:masjid/data/models/timetable_model.dart';
import 'package:masjid/presentation/widgets/timechecker/timechecker.dart';

class TimetableDataWidget extends StatelessWidget {
  final TimetableModel snapshot;
  final DateTime dateTime;
  const TimetableDataWidget({
    super.key,
    required this.snapshot,
    required this.dateTime,
  });

  ///
  static final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
             _EventTile(
                        name: "Sehri",
                        selected: checkForNextPrayer(
                                startTime: '${snapshot.sehriEnd} AM',
                                endTime: '${snapshot.jamFajr} AM'),
                        endTime1: '- -',
                        startTime: snapshot.sehriEnd,
                      ),
                      
                _EventTile(
                  name: "Fajr",
                  selected: checkForNextPrayer(
                              startTime: '${snapshot.begFajr} AM',
                              endTime: '${snapshot.jamFajr} AM'),
                  endTime1: snapshot.jamFajr,
                  startTime: snapshot.begFajr,
                ),
                _EventTile(
                  name: "Sunrise",
                  selected: checkForNextPrayer(
                              startTime: '${snapshot.sunset} AM',
                              endTime: '${snapshot.sunrise} AM'),
                  endTime1: snapshot.sunrise,
                  startTime: snapshot.sunset,
                ),
                checkIfTodayIsFridayAndJummuhIsNotEmpty(
                            dateTime: dateTime,
                            jummah: snapshot.jummah1 ?? '') ==
                        true
                    ? _EventTile(
                        name: "Jummah",
                        selected: checkForNextPrayer(
                                startTime: '${snapshot.jummah2} PM',
                                endTime: '${snapshot.jummah1} PM'),
                        endTime1: checkTheNumberOfJummuah(
                            jummah1: snapshot.jummah1 ?? '',
                            jummah2: snapshot.jummah2 ?? '',
                            jummah3: snapshot.jummah3 ?? '',
                            jummah4: snapshot.jummah4 ?? ''),
                        startTime: '--',
                      )
                    : _EventTile(
                        name: "Dhuhr",
                        selected: checkForNextPrayer(
                                startTime: '${snapshot.begDhuhr} PM',
                                endTime: '${snapshot.jamDhuhr} PM'),
                        endTime1: snapshot.jamDhuhr,
                        startTime: snapshot.begDhuhr,
                      ),
                _EventTile(
                  name: "Asr",
                  selected: checkForNextPrayer(
                              startTime: '${snapshot.begAsar} PM',
                              endTime: '${snapshot.jamAsar} PM'),
                  endTime1: snapshot.jamAsar,
                  startTime: snapshot.begAsar,
                ),
                _EventTile(
                  name: "Maghrib",
                  selected: checkForNextPrayer(
                              startTime: '${snapshot.sunset} PM',
                              endTime: '${snapshot.jamMaghrib} PM'),
                  endTime1: snapshot.jamMaghrib,
                  startTime: snapshot.sunset,
                ),
                _EventTile(
                  name: "Isha",
                  selected: checkForNextPrayer(
                              startTime: '${snapshot.begEsha} PM',
                              endTime: '${snapshot.jamEsha} PM'),
                  endTime1: snapshot.jamEsha,
                  startTime: snapshot.begEsha,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final bool? selected;
  final String? name, startTime, endTime1;

  const _EventTile({
    this.selected,
    this.name,
    this.startTime,
    this.endTime1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          if (selected!) ...[
            // const BoxShadow(
            //   color: Color.fromRGBO(0, 0, 0, 0.1),
            //   offset: Offset(-1, 5),
            //   spreadRadius: 2,
            //   blurRadius: 3,
            // ),
            // const BoxShadow(
            //   color: Color.fromRGBO(0, 0, 0, 0.1),
            //   offset: Offset(0, 0),
            //   spreadRadius: 0,
            //   blurRadius: 0,
            // ),
            // const BoxShadow(
            //   color: Color.fromRGBO(0, 0, 0, 0.1),
            //   offset: Offset(5, 5),
            //   spreadRadius: 1,
            //   blurRadius: 3,
            // ),
          ]
        ],
        color: selected! ? AppColor.backgroundColor : AppColor.lightGreyColor,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(selected! ? 5 : 0)),
        border: Border.all(
          color: selected! ? AppColor.greyBorderColor : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 7.w, vertical: selected! ? 14.h : 9.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name!,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.lightGreyColor3,
                height: 14.0.toFigmaHeight(20),
                fontVariations: const [
                  FontVariation('wght', 700),
                ],
              ),
            ),
            SizedBox(height: 13.h),
            Text(
              checkStartTime(startTime ?? ''),
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColor.lightGreyColor3,
                fontWeight: FontWeight.w700,
                height: 14.0.toFigmaHeight(20),
                fontVariations: const [
                  FontVariation('wght', 700),
                ],
              ),
            ),
            SizedBox(height: 13.h),
            Text(
              checkEndTime(endTime1 ?? ''),
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColor.brownColor,
                fontWeight: FontWeight.bold,
                height: 14.0.toFigmaHeight(20),
                fontVariations: const [
                  FontVariation('wght', 700),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

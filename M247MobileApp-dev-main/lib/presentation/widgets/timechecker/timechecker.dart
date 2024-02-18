import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjid/core/constants/app_constant.dart';
import 'package:masjid/core/extension/datetime_extension.dart';

bool checkPrayerTime(
    {required String startTime,
    required String endTime,
    String eshaEndTime = '',
    PageController? pagecontroller}) {
  DateTime now = DateTime.now();
  final nowAMorPM = DateFormat('a').format(now);
  final startTimeHour = checkForCorrectFormattingStartTime(startTime);

  final startAMorPM = DateFormat('a').format(startTimeHour);
  final endTimeHour = checkForCorrectFormattingEndTime(endTime);

  if (nowAMorPM == startAMorPM) {
    if (now.hour > startTimeHour.hour ||
        (now.hour == startTimeHour.hour &&
            now.minute >= startTimeHour.minute)) {
      if (now.hour < endTimeHour.hour ||
          (now.hour == endTimeHour.hour && now.minute <= endTimeHour.minute)) {
        return true;
      } else {
        return false;
      }
    }
  }

  return false;
}

DateTime checkForCorrectFormattingEndTime(String endTime) {
  if (endTime.contains('.')) {
    String formattedEndTime = endTime.replaceAll('.', ':');
    return DateFormat('h:mm a').parse(formattedEndTime);
  } else {
    return DateFormat('h:mm a').parse(endTime);
  }
}

DateTime checkForCorrectFormattingStartTime(String startTime) {
  if (startTime.contains('.')) {
    String formattedStartTime = startTime.replaceAll('.', ':');
    return DateFormat('h:mm a').parse(formattedStartTime);
  } else {
    return DateFormat('h:mm a').parse(startTime);
  }
}

checkIfEshaHasEnd({
  String eshaEndTime = '',
  required PageController pageController,
  required String startTime,
  required String endTime,
}) {
  DateTime now = DateTime.now();
  final nowAMorPM = DateFormat('a').format(now);
  if (checkPrayerTime(endTime: endTime, startTime: startTime) == false) {
    if (nowAMorPM == 'PM') {
      if (eshaEndTime.isNotEmpty) {
        if (now.formatted() ==
            generate()[pageController.page?.round() ?? 0].formatted()) {
          final formattedEndEshaTime =
              checkForCorrectFormattingEndTime(endTime);
          if (now.hour == formattedEndEshaTime.hour &&
              now.minute >= formattedEndEshaTime.minute) {
            pageController.nextPage(duration: kDuration, curve: Curves.easeIn);
          } else if (now.hour > formattedEndEshaTime.hour && now.hour != 12) {
            pageController.nextPage(duration: kDuration, curve: Curves.easeIn);
          }
        }
      }
    }
  }
}

List<DateTime> generate() {
  DateTime now = DateTime.now();
  final list = List.generate(50, (index) => now.add(Duration(days: index)));
  return list;
}

String checkStartTime(String startTime) {
  if (startTime.contains('.')) {
    String formattedStartTime = startTime.replaceAll('.', ':');
    return formattedStartTime;
  } else {
    return startTime;
  }
}

String checkEndTime(String endTime) {
  if (endTime.contains('.')) {
    String formattedStartTime = endTime.replaceAll('.', ':');
    return formattedStartTime;
  } else {
    return endTime;
  }
}

String checkTheNumberOfJummuah({
  required String jummah1,
  required String jummah2,
  required String jummah3,
  required String jummah4,
}) {
  String emptyString = '';

  if (jummah1 != emptyString &&
      jummah2 != emptyString &&
      jummah3 != emptyString &&
      jummah4 != emptyString) {
    return '$jummah1 / $jummah2 / $jummah3 / $jummah4';
  } else if (jummah1 != emptyString &&
      jummah2 != emptyString &&
      jummah3 != emptyString) {
    return '$jummah1 / $jummah2 / $jummah3';
  } else if (jummah1 != emptyString && jummah2 != emptyString) {
    return '$jummah1 / $jummah2';
  } else if (jummah1 != emptyString) {
    return jummah1;
  } else {
    return '';
  }
}

bool checkIfTodayIsFridayAndJummuhIsNotEmpty({
  required String jummah,
}){
  String emptyString = '';
  final now = DateTime.now();
  if(now.weekday == DateTime.friday){
    if(jummah!=emptyString){
      return true;
    }else{
      return false;
    }
  }
  return false;
}

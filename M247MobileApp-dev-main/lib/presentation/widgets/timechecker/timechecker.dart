import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjid/core/constants/app_constant.dart';
import 'package:masjid/core/extension/datetime_extension.dart';
import 'package:masjid/data/models/masjid_model.dart';

bool checkPrayerTime(
    {required String startTime,
    required String endTime,
    String eshaEndTime = '',
    PageController? pagecontroller}
    ) {
  DateTime now = DateTime.now();
  final nowAMorPM = DateFormat('a').format(now);
  final formattedStartTime = checkForCorrectFormattingStartTime(startTime);

  final startAMorPM = DateFormat('a').format(formattedStartTime);
  final formattedEndTime = checkForCorrectFormattingEndTime(endTime);

  if (nowAMorPM == startAMorPM && formattedEndTime != null) {
    if (now.hour > formattedStartTime.hour ||
        (now.hour == formattedStartTime.hour &&
            now.minute >= formattedStartTime.minute)) {
      if (now.hour < formattedEndTime.hour ||
          (now.hour == formattedEndTime.hour && now.minute <= formattedEndTime.minute)) {
        return true;
      } else {
        return false;
      }
    }
  }

  return false;
}
bool checkForNextPrayer({required String startTime,
    required String endTime,
    String eshaEndTime = '',
    int? index,
    PageController? pagecontroller}){
      bool isAtIndex1 = false;
      bool isAtIndex2 = false;
      bool isAtIndex3 = false;
      bool isAtIndex4 = false;
      bool isAtIndex5 = false;
      bool isAtIndex6 = false;
      bool isAtIndex7 = false;
      bool isAtIndex8 = false;
      DateTime now = DateTime.now();
  final nowAMorPM = DateFormat('a').format(now);
  final formattedStartTime = checkForCorrectFormattingStartTime(startTime);

  final startAMorPM = DateFormat('a').format(formattedStartTime);
  final formattedEndTime = checkForCorrectFormattingEndTime(endTime);

  if(checkPrayerTime(startTime: startTime, endTime: endTime)==false){
    if(index==1){
      // if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour){
        isAtIndex1=true;
        return true;
      }else{
        isAtIndex1=false;
        return false;
    //  }
    }
    }else if(index==2){
    //  if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour&&isAtIndex1==true ){
        isAtIndex2=true;
        return true;
      }else{
        isAtIndex2=false;
        return false;
    //  }
    }
    }else if(index==3){
    //  if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour&&isAtIndex2==true ){
        isAtIndex3=true;
        return true;
      }else{
        isAtIndex3=false;
        return false;
    //  }
    }
    }else if(index==4){
    //  if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour&&isAtIndex3==true ){
        isAtIndex4=true;
        return true;
      }else{
        isAtIndex4=false;
        return false;
     // }
    }
    }else if(index==5){
    //  if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour&&isAtIndex4==true ){
        isAtIndex5=true;
        return true;
      }else{
        isAtIndex5=false;
        return false;
    //  }
    }
    }else if(index==6){
    //  if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour&&isAtIndex5==true ){
        isAtIndex6=true;
        return true;
      }else{
        isAtIndex6=false;
        return false;
    //  }
    }
    }else if(index==7){
     // if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour&&isAtIndex6==true ){
        isAtIndex7=true;
        return true;
      }else{
        isAtIndex7=false;
        return false;
     // }
    }
    }else if(index==8){
     // if(nowAMorPM == startAMorPM){
      if(now.hour<=formattedStartTime.hour&&isAtIndex7==true ){
        isAtIndex8=true;
        return true;
      }else{
        isAtIndex8=false;
        return false;
    //  }
    }
    }
    
    
  }
  return checkPrayerTime(startTime: startTime, endTime: endTime);
}

DateTime? checkForCorrectFormattingEndTime(String endTime) {
  if (endTime != ' PM' && endTime != ' AM' && endTime != 'Jamea') {
    if (endTime.contains('.')) {
      String formattedEndTime = endTime.replaceAll('.', ':');
      return DateFormat('h:mm a').parse(formattedEndTime);
    } else {
      try {
        return DateFormat('h:mm a').parse(endTime);
      } catch (e) {
        return DateFormat('h:mm a').parse("0:00 PM");
      }
    }
  }
  return null;
}

DateTime checkForCorrectFormattingStartTime(String startTime) {
  if(startTime != ' PM' && startTime != ' AM' && startTime != 'Jamea'){
      if (startTime.contains('.')) {
    String formattedStartTime = startTime.replaceAll('.', ':');
    return DateFormat('h:mm a').parse(formattedStartTime);
  } else {
    try {
      return DateFormat('h:mm a').parse(startTime);
    } catch (e) {
      return DateFormat('h:mm a').parse("0:00 PM");
    }
  }
  }
  return DateFormat('h:mm a').parse("0:00$startTime");
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
          if (formattedEndEshaTime != null) {
            if (now.hour == formattedEndEshaTime.hour &&
                now.minute >= formattedEndEshaTime.minute) {
              pageController.nextPage(
                  duration: kDuration, curve: Curves.easeIn);
            } else if (now.hour > formattedEndEshaTime.hour && now.hour != 12) {
              pageController.nextPage(
                  duration: kDuration, curve: Curves.easeIn);
            }
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
    return '$jummah1\n$jummah2\n$jummah3\n$jummah4';
  } else if (jummah1 != emptyString &&
      jummah2 != emptyString &&
      jummah3 != emptyString) {
    return '$jummah1\n$jummah2\n$jummah3';
  } else if (jummah1 != emptyString && jummah2 != emptyString) {
    return '$jummah1\n$jummah2';
  } else if (jummah1 != emptyString) {
    return jummah1;
  } else {
    return '';
  }
}

bool checkIfTodayIsFridayAndJummuhIsNotEmpty({
  required DateTime dateTime,
  required String jummah,
}) {
  String emptyString = '';
  if (dateTime.weekday == 5) {
    if (jummah != emptyString) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

DateTime chechForHijriAdjustment(MasjidModel masjid){
  DateTime now = DateTime.now();
  if(masjid.hijriDateAdjustment==0){
   return now;
  }else if (masjid.hijriDateAdjustment== -1) {
    return now.subtract(const Duration(days: 1));
  }else if(masjid.hijriDateAdjustment==1){
    return now.add(const Duration(days: 1));
  }else{
    return now;
  }
}
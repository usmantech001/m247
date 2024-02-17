import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formatDate => DateFormat('yyyy/MM/dd').format(this);

  String get formatDay => DateFormat('yyyy/M/d').format(this);

  String formatted() {
    final DateFormat format = DateFormat('EEE, dd MMM');
    return format.format(this);
  }

  String toIslamic() {
    // Convert the Gregorian date to Hijri date
    HijriCalendar islamicDate = HijriCalendar.fromDate(this);

    // Format the date in the desired format
    String formattedDate =
        '${islamicDate.getShortMonthName()} ${islamicDate.hDay}, ${islamicDate.hYear} AH';

    return formattedDate;
  }
}

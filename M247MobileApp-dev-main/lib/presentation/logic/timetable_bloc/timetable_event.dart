import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class TimetableEvent {
  const TimetableEvent();
}

class GetTimetableEvent extends TimetableEvent {
  final int? id;

  const GetTimetableEvent(this.id);
}

class GetTimetableDateEvent extends TimetableEvent {
  final int? id;
  final DateTime? date;

  const GetTimetableDateEvent({
    required this.id,
    required this.date,
  });
}

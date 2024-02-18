import 'dart:async';

import 'package:masjid/core/exports.dart';

class TimePickerBloc extends Bloc<TimePickerEvent, DateTime?> {
  TimePickerBloc() : super(null) {
    on<SelectedTimeEvent>(_onTimeSelected);
  }

  FutureOr<void> _onTimeSelected(
    SelectedTimeEvent event,
    Emitter<DateTime?> emit,
  ) {
    emit(event.selectedDate);
  }
}

abstract class TimePickerEvent {
  const TimePickerEvent();
}

class SelectedTimeEvent extends TimePickerEvent {
  final DateTime selectedDate;

  SelectedTimeEvent(this.selectedDate);
}

import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid/core/exceptions/network_exception.dart';
import 'package:masjid/core/extension/datetime_extension.dart';
import 'package:masjid/data/repository/masjid_repository.dart';
import 'package:masjid/presentation/logic/bloc_state/future_state.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_event.dart';

class TimetableBloc extends Bloc<TimetableEvent, FutureState> {
  TimetableBloc() : super(const FutureState.idle()) {
    on<GetTimetableEvent>(_onGetTimetable);
    on<GetTimetableDateEvent>(_onGetTimetableDate);
  }

  final repository = GetIt.instance<MasjidRepository>();

  FutureOr<void> _onGetTimetableDate(
    GetTimetableDateEvent event,
    Emitter<FutureState> emit,
  ) async {
    emit(const FutureState.loading());
    try {
      final result = await repository.getTimetable(
          id: event.id!.toString(), date: event.date!.formatDate);
      emit(FutureState.data(data: result));
    } on NetworkException catch (e) {
      emit(FutureState.failed(reason: e));
    } catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }

  FutureOr<void> _onGetTimetable(
    GetTimetableEvent event,
    Emitter<FutureState> emit,
  ) async {
    emit(const FutureState.loading());
    final today = DateTime.now();
    try {
      final result = await repository.getTimetable(
          id: event.id.toString(), date: today.formatDate);
      emit(FutureState.data(data: result));
    } on NetworkException catch (e) {
      emit(FutureState.failed(reason: e));
    } catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }
}

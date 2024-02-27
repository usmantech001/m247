import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid/core/exceptions/network_exception.dart';
import 'package:masjid/core/extension/datetime_extension.dart';
import 'package:masjid/data/repository/masjid_repository.dart';
import 'package:masjid/presentation/logic/jummah_bloc/jummah_event.dart';
import 'package:masjid/presentation/logic/bloc_state/future_state.dart';

class JummahBloc extends Bloc<JummahEvent, FutureState> {
  JummahBloc() : super(const FutureState.idle()) {
    on<JummahInitialEvent>(_onGetJummah);
    on<JummahDateEvent>(_onDateJummah);
  }

  final repository = GetIt.instance<MasjidRepository>();

  FutureOr<void> _onGetJummah(
    JummahInitialEvent event,
    Emitter<FutureState> emit,
  ) async {
    emit(const FutureState.loading());
    try {
      DateTime date = DateTime.now();
      final location = event.keyword ?? "preston";
      final result =
          await repository.getJummah(date: date.formatDay, keyword: location);
      emit(FutureState.data(data: result));
    } on NetworkException catch (e) {
      emit(FutureState.failed(reason: e));
    } catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }

  FutureOr<void> _onDateJummah(
    JummahDateEvent event,
    Emitter<FutureState> emit,
  ) async {
    emit(const FutureState.loading());
    try {
      final location = (event.keyword == "") ? 'preston' : event.keyword;
      final result = await repository.getJummah(
        keyword: location,
        date: event.date!.formatDay,
      );
      emit(FutureState.data(data: result));
    } on NetworkException catch (e) {
      emit(FutureState.failed(reason: e));
    } catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }
}

import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid/core/exceptions/network_exception.dart';
import 'package:masjid/data/repository/masjid_repository.dart';
import 'package:masjid/presentation/logic/home_bloc/home_event.dart';
import 'package:masjid/presentation/logic/bloc_state/future_state.dart';

class HomeBloc extends Bloc<HomeEvent, FutureState> {
  HomeBloc() : super(const FutureState.idle()) {
    on<HomeEventGetMasjid>(_onGetMasjid);
    on<HomeDateEvent>(_onDateMasjid);
  }

  final repository = GetIt.instance<MasjidRepository>();

  Future<void> _onGetMasjid(
    HomeEventGetMasjid event,
    Emitter<FutureState> emit,
  ) async {
    emit(const FutureState.loading());
    try {
      final result = await repository.getMasjid(keyword: event.keyword);
      emit(FutureState.data(data: result));
    } on NetworkException catch (e) {
      emit(FutureState.failed(reason: e));
    } catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }

  FutureOr<void> _onDateMasjid(
    HomeDateEvent event,
    Emitter<FutureState> emit,
  ) {
    emit(const FutureState.loading());
    try {
      emit(FutureState.data(data: event.datetime));
    } on NetworkException catch (e) {
      emit(FutureState.failed(reason: e));
    } catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }
}

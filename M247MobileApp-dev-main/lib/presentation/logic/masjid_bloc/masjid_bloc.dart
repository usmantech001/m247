import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid/data/repository/masjid_repository.dart';
import 'package:masjid/presentation/logic/masjid_bloc/masjid_event.dart';
import 'package:masjid/presentation/logic/bloc_state/future_state.dart';

class MasjidBloc extends Bloc<MasjidEvent, FutureState> {
  MasjidBloc() : super(const FutureState.idle()) {
    on<GetMasjidEvent>(_onGetMasjidEvent);
  }

  FutureOr<void> _onGetMasjidEvent(
    GetMasjidEvent event,
    Emitter<FutureState> emit,
  ) async {
    emit(const FutureState.loading());
    try {
      final repository = GetIt.instance<MasjidRepository>();
      final result = await repository.getMasjidDetail(id: event.id.toString());
      emit(FutureState.data(data: result));
    } on Exception catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }
}

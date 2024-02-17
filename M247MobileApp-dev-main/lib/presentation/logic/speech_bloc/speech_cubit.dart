import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid/di/get_it.dart';
import 'package:masjid/domain/speech_to_text_service.dart';
import 'package:masjid/presentation/logic/bloc_state/future_state.dart';

class SpeechCubit extends Cubit<FutureState<String>> {
  SpeechCubit() : super(const FutureState.idle());

  final speech = sl<SpeechTTService>();

  void listen() async {
    emit(const FutureState.loading());
    try {
      await speech.listen((result) {
        emit(FutureState.data(data: result));
        debugPrint("result from speech is $result");
      });
    } on Exception catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }

  void pause() async {
    emit(const FutureState.loading());
    try {
      await speech.stop();
    } on Exception catch (e) {
      emit(FutureState.failed(reason: e.toString()));
    }
  }
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:masjid/domain/local_storage/base_key_value_storage.dart';
import 'package:masjid/domain/local_storage/key_value_storage.dart';
import 'package:masjid/domain/networking/dio_service.dart';
import 'package:masjid/domain/networking/api_service.dart';
import 'package:masjid/data/repository/masjid_repository.dart';
import 'package:masjid/domain/speech_to_text_service.dart';

final sl = GetIt.I;

Future<void> initialize() async {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<KVStorage>(() => KVStorage(sl()));

  sl.registerLazySingleton<ApiService>(() => ApiService(sl()));

  sl.registerLazySingleton<DioService>(() => DioService(client: sl()));

  sl.registerLazySingleton<BaseKVStorage>(() => BaseKVStorage.instance);

  sl.registerLazySingleton<SpeechTTService>(() => SpeechTTService.instance);

  sl.registerLazySingleton<MasjidRepository>(() => MasjidRepository(sl()));
}

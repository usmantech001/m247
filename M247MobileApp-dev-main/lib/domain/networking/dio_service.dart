import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:masjid/core/typedefs/dio_typedef.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:masjid/domain/interceptor/logger_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

class DioService {
  late final Dio _client;

  late final CancelToken _cancelToken;

  DioService({
    required Dio client,
  })  : _client = client,
        _cancelToken = CancelToken() {
    _initialize();
  }

  void _initialize() async {
    final directory = await getTemporaryDirectory();

    var cacheStore =
        HiveCacheStore(directory.path, hiveBoxName: "masjid_caching");

    var cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(days: 1),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) {
        return request.uri.toString();
      },
      allowPostMethod: false,
    );

    // ignore: avoid_single_cascade_in_expression_statements
    _client
      ..interceptors.addAll(
          [DioCacheInterceptor(options: cacheOptions), LoggingInterceptor()]);
  }

  void cancelRequests({CancelToken? cancelToken}) async {
    if (cancelToken == null) {
      _cancelToken.cancel("Request cancelled");
    } else {
      cancelToken.cancel();
    }
  }

  Future get<T>({
    required endpoint,
    Json? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _client.get(
      endpoint,
      options: options,
      queryParameters: params,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  Future<Json> post<T>({
    required endpoint,
    Json? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _client.post(
      endpoint,
      queryParameters: params,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );

    return response.data;
  }
}

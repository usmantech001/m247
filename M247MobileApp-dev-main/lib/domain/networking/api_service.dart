import 'package:dio/dio.dart';
import 'package:masjid/core/typedefs/dio_typedef.dart';
import 'package:masjid/domain/networking/dio_service.dart';
import 'package:masjid/core/exceptions/network_exception.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class ApiService {
  final DioService _dio;

  ApiService(DioService dio) : _dio = dio;

  Future<T> getData<T>({
    required String endpoint,
    Json? params,
    CancelToken? cancelToken,
    required T Function(Json result) response,
  }) async {
    late Json json;
    try {
      final result = await _dio.get<Json>(
        params: params,
        endpoint: endpoint,
        cancelToken: cancelToken,
      );

      json = result;
    } on Exception catch (e) {
      throw NetworkException.getDioException(e);
    }

    try {
      return response(json);
    } on Exception catch (e) {
      throw NetworkException.getDioException(e);
    }
  }

  Future<T> getListData<T>({
    required String endpoint,
    Json? params,
    CancelToken? cancelToken,
    required T Function(List<dynamic> result) response,
  }) async {
    late List<dynamic> json;
    try {
      final result = await _dio.get<List<dynamic>>(
        params: params,
        endpoint: endpoint,
        cancelToken: cancelToken,
        options: _mergeDioAndCacheOptions(),
      );
      json = result as List;
    } on Exception catch (e) {
      throw NetworkException.getDioException(e);
    }

    try {
      return response(json);
    } on Exception catch (e) {
      throw NetworkException.getDioException(e);
    }
  }

  Future<T> postData<T>({
    required String endpoint,
    Json? params,
    CancelToken? cancelToken,
    required T Function(Json result) response,
  }) async {
    late Json json;

    try {
      final result = await _dio.post(
        endpoint: endpoint,
        params: params,
        cancelToken: cancelToken,
        options: Options(),
      );

      json = result;
    } on Exception catch (e) {
      throw NetworkException.getDioException(e);
    }

    try {
      return response(json);
    } on Exception catch (e) {
      throw NetworkException.getDioException(e);
    }
  }

  Options? _mergeDioAndCacheOptions({
    Options? dioOptions,
    CacheOptions? cacheOptions,
  }) {
    if (dioOptions == null && cacheOptions == null) {
      return null;
    } else if (dioOptions == null && cacheOptions != null) {
      return cacheOptions.toOptions();
    } else if (dioOptions != null && cacheOptions == null) {
      return dioOptions;
    }

    final _cacheOptionsMap = cacheOptions!.toExtra();
    final options = dioOptions!.copyWith(
      extra: <String, dynamic>{...dioOptions.extra!, ..._cacheOptionsMap},
    );
    return options;
  }
}

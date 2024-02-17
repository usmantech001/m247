import 'package:dio/dio.dart';
import 'package:masjid/data/models/jummah_model.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/core/constants/api_constant.dart';
import 'package:masjid/data/models/timetable_model.dart';
import 'package:masjid/domain/networking/api_service.dart';
import 'package:masjid/data/models/masjid_detail_model.dart';

class MasjidRepository {
  final ApiService _apiService;

  MasjidRepository(ApiService apiService) : _apiService = apiService;

  Future<List<MasjidModel>> getMasjid({String? keyword}) async {
    final request = _apiService.getData(
      params: {},
      cancelToken: CancelToken(),
      endpoint: "${ApiConstant.masjids}$keyword",
      response: (response) {
        final result = response['data'] as List;
        List<MasjidModel> items = [];
        for (var i in result) {
          final item = MasjidModel.fromJson(i);
          items.add(item);
        }
        return items;
      },
    );
    return await request;
  }

  Future<MasjidDetail> getMasjidDetail({required String id}) async {
    final request = _apiService.getData(
      params: {},
      cancelToken: CancelToken(),
      endpoint: "${ApiConstant.masjid}$id",
      response: (response) {
        List<MasjidDetail> items = [];
        final result = response['data'] as List;
        for (var i in result) {
          final item = MasjidDetail.fromJson(i);
          items.add(item);
        }
        return items.first;
      },
    );
    return await request;
  }

  Future<List<JummahModel>> getJummah({
    String? keyword,
    required String date,
  }) async {
    final request = _apiService.getListData(
      params: {},
      cancelToken: CancelToken(),
      endpoint: "${ApiConstant.jummah}$keyword/$date",
      response: (response) {
        List<JummahModel> items = [];
        final result = response.map((e) => JummahModel.fromJson(e)).toList();
        for (var i in result) {
          items.add(i);
        }
        return items;
      },
    );
    return await request;
  }

  Future<TimetableModel> getTimetable({String? id, String? date}) async {
    final request = _apiService.getData(
      params: {},
      cancelToken: CancelToken(),
      endpoint: "${ApiConstant.timetable}$id/$date",
      response: (response) {
        List<TimetableModel> items = [];
        final result = response['data'] as List;
        for (var i in result) {
          final item = TimetableModel.fromJson(i);
          items.add(item);
        }
        return items.first;
      },
    );
    return await request;
  }
}

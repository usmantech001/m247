import 'package:masjid/core/typedefs/dio_typedef.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/data/models/timetable_model.dart';

class FavoriteModel {
  int? id;
  MasjidModel? masjid;
  TimetableModel? timetable;

  FavoriteModel({
    this.id,
    this.masjid,
    this.timetable,
  });

  FavoriteModel.fromJson(Json json) {
    id = json['id'];
    masjid = MasjidModel.fromJson(json['masjid']);
    timetable = TimetableModel.fromJson(json['timetable']);
  }

  Json toJson() {
    Json data = <String, dynamic>{};
    data['id'] = id;
    data['masjid'] = masjid!.toJson();
    data['timetable'] = timetable!.toJson();
    return data;
  }
}

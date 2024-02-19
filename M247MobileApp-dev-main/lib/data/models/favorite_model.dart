import 'package:masjid/core/typedefs/dio_typedef.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/data/models/timetable_model.dart';

class FavoriteModel {
  int? id;
  MasjidModel? masjid;
  TimetableModel? timetable;
  String? dateTime;

  FavoriteModel({
    this.id,
    this.masjid,
    this.timetable,
    this.dateTime,
  });

  FavoriteModel.fromJson(Json json) {
    id = json['id'];
    dateTime = json['dateTime'];
    masjid = MasjidModel.fromJson(json['masjid']);
    timetable = TimetableModel.fromJson(json['timetable']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['dateTime'] = dateTime;
    data['masjid'] = masjid!.toJson();
    data['timetable'] = timetable!.toJson();
    return data;
  }
}

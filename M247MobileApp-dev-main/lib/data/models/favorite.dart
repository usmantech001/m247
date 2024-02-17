import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/data/models/timetable_model.dart';

class FavoriteModel2 {
  int? id;
  MasjidModel? masjid;
  TimetableModel? timetable;

  FavoriteModel2({
    this.id,
    this.masjid,
    this.timetable,
  });

  FavoriteModel2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    masjid = MasjidModel.fromJson(json['masjid']);
    timetable = TimetableModel.fromJson(json['timetable']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['masjid'] = masjid!.toJson();
    data['timetable'] = timetable!.toJson();
    return data;
  }
}

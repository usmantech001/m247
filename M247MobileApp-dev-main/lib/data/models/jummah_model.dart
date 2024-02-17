import 'package:masjid/core/typedefs/dio_typedef.dart';

class JummahModel {
  int? id;
  String? name;
  String? year;
  String? month;
  String? date;
  String? jummah1;
  String? jummah2;
  String? jummah3;
  String? jummah4;

  JummahModel({
    this.id,
    this.name,
    this.year,
    this.month,
    this.date,
    this.jummah1,
    this.jummah2,
    this.jummah3,
    this.jummah4,
  });

  JummahModel.fromJson(Json json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    month = json['month'];
    date = json['date'];
    jummah1 = json['jummah1'];
    jummah2 = json['jummah2'];
    jummah3 = json['jummah3'];
    jummah4 = json['jummah4'];
  }

  Json toJson() {
    final Json data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['year'] = year;
    data['month'] = month;
    data['date'] = date;
    data['jummah1'] = jummah1;
    data['jummah2'] = jummah2;
    data['jummah3'] = jummah3;
    data['jummah4'] = jummah4;
    return data;
  }
}

import 'package:masjid/core/typedefs/dio_typedef.dart';

class TimetableModel {
  int? id;
  int? masjidId;
  String? name;
  int? hijriDateAdjustment;
  String? color;
  String? freeText;
  String? year;
  String? month;
  String? date;
  String? day;
  String? dateHijri;
  String? sehriEnd;
  String? begFajr;
  String? sunrise;
  String? noon;
  String? begDhuhr;
  String? begAsar;
  String? begAsar2;
  String? sunset;
  String? begEsha;
  String? jamFajr;
  String? jamDhuhr;
  String? jamAsar;
  String? jamMaghrib;
  String? jamEsha;
  String? jummah1;
  String? jummah2;
  String? jummah3;
  String? jummah4;
  bool? isDeleted;

  TimetableModel({
    this.id,
    this.masjidId,
    this.name,
    this.hijriDateAdjustment,
    this.color,
    this.freeText,
    this.year,
    this.month,
    this.date,
    this.day,
    this.dateHijri,
    this.sehriEnd,
    this.begFajr,
    this.sunrise,
    this.noon,
    this.begDhuhr,
    this.begAsar,
    this.begAsar2,
    this.sunset,
    this.begEsha,
    this.jamFajr,
    this.jamDhuhr,
    this.jamAsar,
    this.jamMaghrib,
    this.jamEsha,
    this.jummah1,
    this.jummah2,
    this.jummah3,
    this.jummah4,
    this.isDeleted,
  });

  TimetableModel.fromJson(Json json) {
    id = json['id'];
    masjidId = json['masjidId'];
    name = json['name'];
    hijriDateAdjustment = json['hijriDateAdjustment'];
    color = json['color'];
    freeText = json['freeText'];
    year = json['year'];
    month = json['month'];
    date = json['date'];
    day = json['day'];
    dateHijri = json['dateHijri'];
    sehriEnd = json['sehriEnd'];
    begFajr = json['begFajr'];
    sunrise = json['sunrise'];
    noon = json['noon'];
    begDhuhr = json['begDhuhr'];
    begAsar = json['begAsar'];
    begAsar2 = json['begAsar2'];
    sunset = json['sunset'];
    begEsha = json['begEsha'];
    jamFajr = json['jamFajr'];
    jamDhuhr = json['jamDhuhr'];
    jamAsar = json['jamAsar'];
    jamMaghrib = json['jamMaghrib'];
    jamEsha = json['jamEsha'];
    jummah1 = json['jummah1'];
    jummah2 = json['jummah2'];
    jummah3 = json['jummah3'];
    jummah4 = json['jummah4'];
    isDeleted = json['isDeleted'];
  }

  Json toJson() {
    Json data = <String, dynamic>{};
    data['id'] = id;
    data['masjidId'] = masjidId;
    data['name'] = name;
    data['hijriDateAdjustment'] = hijriDateAdjustment;
    data['color'] = color;
    data['freeText'] = freeText;
    data['year'] = year;
    data['month'] = month;
    data['date'] = date;
    data['day'] = day;
    data['dateHijri'] = dateHijri;
    data['sehriEnd'] = sehriEnd;
    data['begFajr'] = begFajr;
    data['sunrise'] = sunrise;
    data['noon'] = noon;
    data['begDhuhr'] = begDhuhr;
    data['begAsar'] = begAsar;
    data['begAsar2'] = begAsar2;
    data['sunset'] = sunset;
    data['begEsha'] = begEsha;
    data['jamFajr'] = jamFajr;
    data['jamDhuhr'] = jamDhuhr;
    data['jamAsar'] = jamAsar;
    data['jamMaghrib'] = jamMaghrib;
    data['jamEsha'] = jamEsha;
    data['jummah1'] = jummah1;
    data['jummah2'] = jummah2;
    data['jummah3'] = jummah3;
    data['jummah4'] = jummah4;
    data['isDeleted'] = isDeleted;
    return data;
  }
}

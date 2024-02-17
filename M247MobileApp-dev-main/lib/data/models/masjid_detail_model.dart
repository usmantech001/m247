import 'package:masjid/core/typedefs/dio_typedef.dart';

class MasjidDetail {
  int? id;
  String? name;
  String? alias;
  String? addressLine1;
  String? addressLine2;
  String? town;
  String? postcode;
  String? latitude;
  String? longitude;
  String? websiteURL;
  String? transmitter;
  String? email1;
  String? youtube;
  String? tel1;
  String? freeText;
  int? hijriDateAdjustment;
  String? audioStream;
  String? color;
  String? eidPrayerFirst;
  String? eidPrayerSecond;
  String? eidPrayerThird;
  String? whatsAppLink;

  MasjidDetail({
    this.id,
    this.name,
    this.alias,
    this.addressLine1,
    this.addressLine2,
    this.town,
    this.postcode,
    this.latitude,
    this.longitude,
    this.websiteURL,
    this.transmitter,
    this.email1,
    this.youtube,
    this.tel1,
    this.freeText,
    this.hijriDateAdjustment,
    this.audioStream,
    this.color,
    this.eidPrayerFirst,
    this.eidPrayerSecond,
    this.eidPrayerThird,
    this.whatsAppLink,
  });

  MasjidDetail.fromJson(Json json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    town = json['town'];
    postcode = json['postcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    websiteURL = json['websiteURL'];
    transmitter = json['transmitter'];
    email1 = json['email1'];
    youtube = json['youtube'];
    tel1 = json['tel1'];
    freeText = json['freeText'];
    hijriDateAdjustment = json['hijriDateAdjustment'];
    audioStream = json['audioStream'];
    color = json['color'];
    eidPrayerFirst = json['eidPrayerFirst'];
    eidPrayerSecond = json['eidPrayerSecond'];
    eidPrayerThird = json['eidPrayerThird'];
    whatsAppLink = json['whatsAppLink'];
  }

  Map<String, dynamic> toJson() {
    final Json data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['town'] = town;
    data['postcode'] = postcode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['websiteURL'] = websiteURL;
    data['transmitter'] = transmitter;
    data['email1'] = email1;
    data['youtube'] = youtube;
    data['tel1'] = tel1;
    data['freeText'] = freeText;
    data['hijriDateAdjustment'] = hijriDateAdjustment;
    data['audioStream'] = audioStream;
    data['color'] = color;
    data['eidPrayerFirst'] = eidPrayerFirst;
    data['eidPrayerSecond'] = eidPrayerSecond;
    data['eidPrayerThird'] = eidPrayerThird;
    data['whatsAppLink'] = whatsAppLink;
    return data;
  }
}

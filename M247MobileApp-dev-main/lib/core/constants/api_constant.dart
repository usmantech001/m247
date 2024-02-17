class ApiConstant {
  ApiConstant._();

  // ignore: constant_identifier_names
  static const String BASE_URL = "https://m365devuk.azurewebsites.net/";

  static const String masjid = "${BASE_URL}api/masjid/";
  static const String masjids = "${BASE_URL}api/masjid/search/";
  static const String jummah = "${BASE_URL}api/timetable/jummah/";
  static const String timetable = "${BASE_URL}api/timetable/";

  static const devLogo =
      "https://m365devuk.blob.core.windows.net/masaajidimages/logos/";

  static const int receiveTimeout = 5000;

  static const int connectionTimeout = 3000;
}

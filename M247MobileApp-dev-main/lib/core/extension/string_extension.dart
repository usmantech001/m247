import 'dart:convert';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String toSvg() => 'assets/svgs/$this.svg';

  String toImage() => 'assets/images/$this.png';

  String toDevLogo() =>
      "https://m365devuk.blob.core.windows.net/masaajidimages/$this.png";

  String toDevImage() =>
      "https://m365devuk.blob.core.windows.net/masaajidimages/$this.png";
}

extension Conversion on String {
  String convertStringToBase64() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(this);
  }
}

extension FormatDate on String {
  String formatDate(String inFormat, String outFormat) {
    DateTime parseDate = DateFormat(inFormat).parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(outFormat);
    return outputFormat.format(inputDate);
  }
}

import 'package:http/http.dart' as http;

class ApiRequest {
  ///This function takes latitude , longitude , month and year , sends them to a free API and gets
  ///the prayer timings of the whole month according to the geolocation
  static Future<http.Response> returnPrayerTimes(
      {required double latitude,
      required double longitude,
      required int month,
      required int year}) {
    return http.get(Uri.parse(
        'http://api.aladhan.com/v1/calendar?latitude=$latitude&longitude=$longitude&method=2&month=$month&year=$year'));
  }
}

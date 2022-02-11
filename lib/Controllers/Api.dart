import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<http.Response> returnprayertimes(
      {required double latitude,
      required double longitude,
      required int month,
      required int year}) {
    return http.get(Uri.parse(
        'http://api.aladhan.com/v1/calendar?latitude=$latitude&longitude=$longitude&method=2&month=$month&year=$year'));
  }
}

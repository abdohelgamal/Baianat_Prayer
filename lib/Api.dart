import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<http.Response> returnprayertimes(double lat, double lon) {
    return http.get(Uri.parse(
        'http://api.aladhan.com/v1/calendar?latitude=$lat&longitude=$lon&method=2&month=${DateTime.now().month}&year=${DateTime.now().year}'));
  }
}

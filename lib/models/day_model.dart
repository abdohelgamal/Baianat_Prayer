///A class that represents the timings data for each day of the month and maps the data correctly into the model

class Day {
  List<String> timings = [];
  late String dateTime;

  ///This function takes a map containing the timings of the day , removes unnecessary timings and maps the
  ///rest timings into the model
  static Day parseFromMap(Map map) {
    Day day = Day();
    day.dateTime = map['date']['gregorian']['date'];
    Map temp = map['timings'] as Map;
    temp.removeWhere((k, v) {
      if (k == 'Sunrise' || k == 'Sunset' || k == 'Imsak' || k == 'Midnight') {
        return true;
      } else {
        return false;
      }
    });
    temp.forEach((key, value) => day.timings.add(value));
    return day;
  }
}

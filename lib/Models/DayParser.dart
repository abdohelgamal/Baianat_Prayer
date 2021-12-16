class Day {
  List<String> timings = [];
  late String dateTime;

 static Day parsefromMap(Map map) {
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

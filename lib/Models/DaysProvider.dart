import 'dart:convert';
import 'package:baianat_prayer/Controllers/Api.dart';
import 'package:baianat_prayer/Models/DayParser.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysBlocCubit extends Cubit<List<Day>> {
  DaysBlocCubit() : super(List.empty());

  List<Day> daysData = [];
  void clearData() {
    daysData = List.empty();
    emit(daysData);
  }

  Future<void> getMonthData(
      double longitude, double latitude, int month, int year) async {
    ApiRequest.returnPrayerTimes(
            longitude: longitude, latitude: latitude, month: month, year: year)
        .then((value) {
      var res = jsonDecode(value.body);
      List data = res['data'] as List;
      daysData = data.map((day) {
        return Day.parseFromMap(day);
      }).toList();
      emit(daysData);
    });
  }
}

import 'dart:convert';
import 'package:baianat_prayer/Controllers/Api.dart';
import 'package:baianat_prayer/Models/DayParser.dart';
import 'package:baianat_prayer/Models/Notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///A [Cubit] class to handle state management of the application and rebuild events
class DaysBlocCubit extends Cubit<List<Day>> {
  DaysBlocCubit() : super(List.empty());

  List<Day> daysData = [];

  ///Clears data stored in the [Cubit] and updates its state
  void clearData() {
    daysData = List.empty();
    emit(daysData);
  }

  ///This function takes latitude , longitude , month and year and uses [ApiRequest] to send them to the API in case the internet
  ///connectivity is available, and then handles the data received to show them and show a success notification,
  ///else it shows  failure notification
  Future<void> getMonthData(
      double longitude, double latitude, int month, int year) async {
    var _connectivity = Connectivity();
    ConnectivityResult status = await _connectivity.checkConnectivity();
    if (status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi) {
      ApiRequest.returnPrayerTimes(
              longitude: longitude,
              latitude: latitude,
              month: month,
              year: year)
          .then((value) {
        var res = jsonDecode(value.body);
        List data = res['data'] as List;
        daysData = data.map((day) {
          return Day.parseFromMap(day);
        }).toList();
        emit(daysData);
        Notifications.success();
      });
    } else {
      Notifications.failed();
    }
  }
}

import 'dart:convert';
import 'package:baianat_prayer/Controllers/Api.dart';
import 'package:baianat_prayer/Controllers/Functions.dart';
import 'package:baianat_prayer/Controllers/Locationservice.dart';
import 'package:baianat_prayer/Models/DayParser.dart';
import 'package:baianat_prayer/View/Prayer_Time_ListTile_Component.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selecteddate = DateTime.now();
  List<Day> daysdata = [];
  Map<int, String> months = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'Septemper',
    10: 'October',
    11: 'November',
    12: 'December'
  };
<<<<<<< Updated upstream
  late double lat;
  late double lon;
  DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month, 1);
  @override
  void initState() {
    super.initState();
=======
  var scaffoldKey = GlobalKey();
  var datePickerKey = GlobalKey();
  late double lat;
  late double lon;
  DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month, 1);
  late DatePickerController datecontroller;
  @override
  void initState() {
    super.initState();
    datecontroller = DatePickerController();
    var bloc = BlocProvider.of<DaysBlocCubit>(context);

>>>>>>> Stashed changes
    LocationService.gettingPermAndLoc().then((value) {
      lat = value.latitude!;
      lon = value.longitude!;
      ApiRequest.returnprayertimes(
              longitude: lon,
              latitude: lat,
              month: DateTime.now().month,
              year: DateTime.now().year)
          .then((value) {
        var res = jsonDecode(value.body);
        List data = res['data'] as List;
        setState(() {
          daysdata = data.map((day) {
            return Day.parsefromMap(day);
          }).toList();
        });
      });
      Future.delayed(const Duration(seconds: 0)).then((value) {
        setState(() {
          selecteddate = DateTime.now();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${months[selecteddate.month]} ${selecteddate.year}',
                      style: TextStyle(
                          color: Colors.lightBlue[900],
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        IconButton(
                            splashColor: Colors.blue,
                            splashRadius: 30,
                            color: Colors.lightBlue[900],
                            iconSize: 30,
                            onPressed: () {
                              startTime = decreaseMonth(startTime);
                              selecteddate = startTime;
                              ApiRequest.returnprayertimes(
                                      longitude: lon,
                                      latitude: lat,
                                      month: selecteddate.month,
                                      year: selecteddate.year)
                                  .then((value) {
                                var res = jsonDecode(value.body);
                                List data = res['data'] as List;
                                setState(() {
                                  daysdata = data.map((day) {
                                    return Day.parsefromMap(day);
                                  }).toList();
                                });
                              });
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        IconButton(
                            splashColor: Colors.blue,
                            splashRadius: 30,
                            color: Colors.lightBlue[900],
                            iconSize: 30,
                            onPressed: () {
                              startTime = increaseMonth(startTime);
                              selecteddate = startTime;
                              ApiRequest.returnprayertimes(
                                      longitude: lon,
                                      latitude: lat,
                                      month: selecteddate.month,
                                      year: selecteddate.year)
                                  .then((value) {
                                var res = jsonDecode(value.body);
                                List data = res['data'] as List;
                                setState(() {
                                  daysdata = data.map((day) {
                                    return Day.parsefromMap(day);
                                  }).toList();
                                });
                              });
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    )
                  ],
                ),
                DatePicker(
                  startTime,
                  width: 70,height: 90,
                  daysCount: daysdata.length,dateTextStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                  selectionColor: Colors.tealAccent.shade400,
                  selectedTextColor: Colors.blue.shade600,
                  initialSelectedDate: selecteddate,
                  onDateChange: (selectedDate) {
                    setState(() {
                      selecteddate = selectedDate;
                    });
                  },
=======
    DaysBlocCubit blocCubit = BlocProvider.of<DaysBlocCubit>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.cyan[100],
      body: BlocConsumer<DaysBlocCubit, List<Day>>(
          listener: (context, state) {},
          builder: (context, state) => SafeArea(
                  child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${months[selectedDate.month]} ${selectedDate.year}',
                            style: TextStyle(
                                color: Colors.lightBlue[900],
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  splashColor: Colors.blue,
                                  splashRadius: 30,
                                  color: Colors.lightBlue[900],
                                  iconSize: 30,
                                  onPressed: () {
                                    startTime = decreaseMonth(startTime);
                                    selectedDate = startTime;
                                    blocCubit.clearData();
                                    blocCubit
                                        .getMonthData(
                                            lon,
                                            lat,
                                            selectedDate.month,
                                            selectedDate.year)
                                        .whenComplete(() => datecontroller
                                            .animateToDate(selectedDate));
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                              IconButton(
                                  splashColor: Colors.blue,
                                  splashRadius: 30,
                                  color: Colors.lightBlue[900],
                                  iconSize: 30,
                                  onPressed: () {
                                    startTime = increaseMonth(startTime);
                                    selectedDate = startTime;
                                    blocCubit.clearData();
                                    blocCubit
                                        .getMonthData(
                                            lon,
                                            lat,
                                            selectedDate.month,
                                            selectedDate.year)
                                        .whenComplete(() => datecontroller
                                            .animateToDate(selectedDate));
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          )
                        ],
                      ),
                      DatePicker(
                        startTime,
                        key: datePickerKey,
                        controller: datecontroller,
                        width: 70,
                        height: 90,
                        daysCount: blocCubit.daysData.length,
                        dateTextStyle: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                        selectionColor: Colors.tealAccent.shade400,
                        selectedTextColor: Colors.blue.shade600,
                        initialSelectedDate: selectedDate,
                        onDateChange: (changed) {
                          setState(() {
                            selectedDate = changed;
                          });
                        },
                      ),
                    ],
                  ),
>>>>>>> Stashed changes
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(35))),
                child: daysdata.isEmpty
                    ? const CircularProgressIndicator(
                        color: Colors.red,
                      )
                    : Center(
                        child: PrayerTimes(
                          list: daysdata[selecteddate.day - 1].timings,
                        ),
                      )),
          ),
        ])));
  }
}

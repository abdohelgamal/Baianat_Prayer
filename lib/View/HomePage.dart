import 'package:baianat_prayer/Controllers/Functions.dart';
import 'package:baianat_prayer/Controllers/Locationservice.dart';
import 'package:baianat_prayer/Models/DayParser.dart';
import 'package:baianat_prayer/Models/DaysProvider.dart';
import 'package:baianat_prayer/View/Prayer_Time_ListTile_Component.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

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
  var scaffoldKey = GlobalKey();
  late double lat;
  late double lon;
  DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  void initState() {
    super.initState();

    var bloc = BlocProvider.of<DaysBlocCubit>(context);

    LocationService.gettingPermAndLoc().then((value) {
      lat = value.latitude!;
      lon = value.longitude!;
      bloc.getMonthData(lon, lat, DateTime.now().month, DateTime.now().year);
    });

    Future.delayed(const Duration(seconds: 0)).then((value) {
      setState(() {
        selectedDate = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DaysBlocCubit blocCubit = BlocProvider.of<DaysBlocCubit>(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.cyan[100],
      body: BlocConsumer<DaysBlocCubit, List<Day>>(
          listener: (BuildContext context, state) {},
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
                                    blocCubit.getMonthData(lon, lat,
                                        selectedDate.month, selectedDate.year);
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
                                    blocCubit.getMonthData(lon, lat,
                                        selectedDate.month, selectedDate.year);
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          )
                        ],
                      ),
                      DatePicker(
                        startTime,
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
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(35))),
                  child: blocCubit.daysData.isEmpty
                      ? const SpinKitFadingCube(
                          duration: Duration(milliseconds: 500),
                          color: Colors.red,
                        )
                      : PrayerTimes(
                          list:
                              blocCubit.daysData[selectedDate.day - 1].timings,
                        ),
                )),
              ]))),
    );
  }
}

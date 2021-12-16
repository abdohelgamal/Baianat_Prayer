import 'dart:convert';
import 'package:baianat_prayer/Api.dart';
import 'package:baianat_prayer/DayParser.dart';
import 'package:baianat_prayer/Locationservice.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
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
  List<String> prayerNames = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
      late double lat;
    late double lon;

  @override
  void initState() {
    super.initState();
    selecteddate = DateTime.now();
    late double latitude;
    late double longitude;
    LocationService.gettingPermAndLoc().then((value) {
      latitude = value.latitude!;
      lat = value.latitude!;
      longitude = value.longitude!;
      lon = value.longitude!;
      ApiRequest.returnprayertimes(longitude, latitude).then((value) {
        var res = jsonDecode(value.body);

        List data = res['data'] as List;

        setState(() {
          daysdata = data.map((day) {
            return Day().parsefromMap(day);
          }).toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: SafeArea(
        child: Column(
          children: [
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
                          IconButton(splashColor: Colors.blue,splashRadius: 35,
                              color: Colors.lightBlue[900],
                              iconSize: 35,
                              onPressed: () {
                                setState(() {
                                  selecteddate
                                      .subtract(const Duration(days: 28));
                                });
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          IconButton(splashColor: Colors.blue,splashRadius: 35,
                              color: Colors.lightBlue[900],
                              iconSize: 35,
                              onPressed: () {
                                setState(() {
                                  selecteddate.add(const Duration(days: 28));
                                });
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      )
                    ],
                  ),
                  DatePicker(
                    DateTime(DateTime.now().year, DateTime.now().month , 1),
                    width: MediaQuery.of(context).size.width / 9,
                    daysCount: daysdata.length,
                    initialSelectedDate: selecteddate,
                    onDateChange: (selectedDate) {
                      setState(() {
                        selecteddate = selectedDate;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(35))),
                  child: daysdata.isEmpty
                      ? const CircularProgressIndicator(
                          color: Colors.red,
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            title: Text(
                              prayerNames[index],
                              style: const TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.w600),
                            ),
                            trailing: Text(
                                daysdata[selecteddate.day - 1].timings[index],
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600)),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1.2,
                            color: Colors.cyan,
                            indent: 20,
                            endIndent: 20,
                          ),
                          itemCount:
                              daysdata[selecteddate.day - 1].timings.length,
                        )),
            )
          ],
        ),
      ),
    );
  }
}

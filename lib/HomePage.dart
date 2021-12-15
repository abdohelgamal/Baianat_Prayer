import 'dart:convert';
import 'package:baianat_prayer/Api.dart';
import 'package:baianat_prayer/Locationservice.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var todaydata ;
  @override
  void initState() {
    super.initState();
    var todaydata;
   late double latitude ;
   late double longitude ;
    LocationService.gettingPermAndLoc().then((value) {
      latitude = value.latitude!;
      longitude = value.longitude!;
       ApiRequest.returnprayertimes(longitude, latitude).then(( value) {
      var res = jsonDecode(value.body);
      print(res);
      // setState(() {
      //   todaydata = res['results']['datetime'] as List;
      // });
      // print(todaydata);
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
                        'August 2020',
                        style: TextStyle(
                            color: Colors.lightBlue[900],
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          IconButton(
                              color: Colors.lightBlue[900],
                              iconSize: 35,
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_back_ios)),
                          IconButton(
                              color: Colors.lightBlue[900],
                              iconSize: 35,
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      )
                    ],
                  ),
                  DatePicker(
                    //TODO: adjust styling of days
                    DateTime(DateTime.now().year, 0, 1),
                    width: MediaQuery.of(context).size.width / 9,
                    daysCount: 31,
                    initialSelectedDate: DateTime.now(),
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
                  child:
                      // ? CircularProgressIndicator(
                      //     color: Colors.red,
                      //   )
                      // :
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => const ListTile(
                                contentPadding: EdgeInsets.all(15),
                                title: Text(
                                  'dfdsf',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text('sda',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600)),
                              ),
                          separatorBuilder: (context, index) => const Divider(
                                thickness: 1.2,
                                color: Colors.cyan,
                                indent: 20,
                                endIndent: 20,
                              ),
                          itemCount: 5)),
            )
          ],
        ),
      ),
    );
  }
}

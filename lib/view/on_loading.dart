import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///This widget component represents the loading part of the screen while requesting the data from
///the API or in case failure to send the request or no internet connection

class OnLoading extends StatefulWidget {
  const OnLoading({Key? key}) : super(key: key);

  @override
  _OnLoadingState createState() => _OnLoadingState();
}

class _OnLoadingState extends State<OnLoading> {
  String load = '';

  @override
  void initState() {
    // In case no data received in five seconds the text is changed and cancels the setstate callback after the timer
    //finishes in case data received and screen updated to prevent memory leak

    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          load = 'Please check your network and enable location permessions';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          load,
          maxLines: 2,
          softWrap: true,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color.fromARGB(255, 4, 59, 155), fontSize: 22),
        ),
        const SizedBox(
          height: 30,
        ),
        const SpinKitFadingCube(
          duration: Duration(milliseconds: 500),
          color: Colors.red,
        ),
      ],
    );
  }
}

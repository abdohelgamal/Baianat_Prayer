import 'package:flutter/material.dart';

class PrayerTime extends StatelessWidget {
  PrayerTime({required this.time, required this.prayer});
  late String time;
  late String prayer;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      title: Text(
        prayer,
        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
      ),
      trailing: Text(time,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
    );
  }
}

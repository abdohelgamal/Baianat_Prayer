import 'package:flutter/material.dart';

///This widget component represents the [ListView] that contains the [ListTile]s showing timings as a text
class PrayerTimes extends StatelessWidget {
  PrayerTimes({
    Key? key,
    required this.list,
  }) : super(key: key);
  late List list;
  List<String> prayerNames = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
        title: Text(
          prayerNames[index],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        trailing: Text(list[index],
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      ),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1.2,
        color: Colors.cyan,
        indent: 30,
        endIndent: 30,
      ),
      itemCount: 5,
    );
  }
}

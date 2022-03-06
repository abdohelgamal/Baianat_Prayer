import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayerapp/controllers/bloc_observer.dart';
import 'package:prayerapp/controllers/days_bloc.dart';
import 'package:prayerapp/models/notifications.dart';
import 'package:prayerapp/view/home_page.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //Starts notifications chennel service

    Notifications.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DaysBlocCubit(),
        child: MaterialApp(
            debugShowCheckedModeBanner: true,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomePage()));
  }
}

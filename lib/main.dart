import 'package:baianat_prayer/Models/BlocObserver.dart';
import 'package:baianat_prayer/Models/DaysProvider.dart';
import 'package:baianat_prayer/Models/Notifications.dart';
import 'package:baianat_prayer/View/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

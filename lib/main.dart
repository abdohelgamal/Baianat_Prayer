import 'package:baianat_prayer/Models/BlocObserver.dart';
import 'package:baianat_prayer/View/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Models/DaysProvider.dart';

void main() {
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
            create: (context) => DaysBlocCubit(), child: HomePage()));
  }
}

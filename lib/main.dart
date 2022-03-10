import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayerapp/controllers/days_bloc.dart';
import 'package:prayerapp/controllers/notifications.dart';
import 'package:prayerapp/view/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() {
    Notifications.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

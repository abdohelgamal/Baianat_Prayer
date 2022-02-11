
import 'package:baianat_prayer/View/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
<<<<<<< Updated upstream
=======
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
>>>>>>> Stashed changes
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
        debugShowCheckedModeBanner: true,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

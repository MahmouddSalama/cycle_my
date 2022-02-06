import 'package:cycle_my/screens/body/adminbody/screens/home_screen.dart';
import 'package:cycle_my/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cycle Me',
      home: SplashScreen(),
    );
  }
}


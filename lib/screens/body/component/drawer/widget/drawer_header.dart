import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DrawerHeader(
        child: Image.asset('assets/image/logo.png',fit: BoxFit.fill,),
      ),
    );
  }
}

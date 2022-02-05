
import 'package:cycle_my/screens/body/component/drawer/widget/category.dart';
import 'package:cycle_my/screens/body/component/drawer/widget/drawer_header.dart';
import 'package:cycle_my/screens/body/userbody/screens/orders.dart';
import 'package:flutter/material.dart';

import '../../user_account.dart';


class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          MyDrawerHeader(),
          CategoryListTileGarage(
            text: 'My Account',
            function: () {
              // got to profile page
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserAccount()));
            },
            iconData: Icons.person,
          ),
          CategoryListTileGarage(
            text: 'My Orders',
            function: () {
              // got to orders page
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserOrders()));
            },
            iconData: Icons.open_with_rounded,
          ),

         const Divider(height: 3, color: Colors.indigoAccent),
          CategoryListTileGarage(
            text: 'Logout',
            function: () {
              // FirebaseAuth.instance.signOut();
              // for(;Navigator.canPop(context);){
              //   Navigator.pop(context);
              // }
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen(
              // )));
            },
            iconData: Icons.logout,
          ),
        ],
      ),
    );
  }
}
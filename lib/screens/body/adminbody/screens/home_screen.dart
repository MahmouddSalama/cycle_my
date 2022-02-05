import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/body/adminbody/components/main_widgei.dart';
import 'package:cycle_my/screens/body/adminbody/screens/add_cycle.dart';
import 'package:cycle_my/screens/body/adminbody/screens/all_cycle.dart';
import 'package:cycle_my/screens/body/adminbody/screens/all_orders.dart';
import 'package:cycle_my/screens/body/adminbody/screens/all_users.dart';
import 'package:cycle_my/screens/body/component/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('Home'),
      ),
      drawer: DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 10,),
                SizedBox(
                    width: 500,
                    height: 100,
                    child: Image.asset(
                      "assets/image/logo.png",
                      fit: BoxFit.contain,
                    )),
                MainWidget(
                  text: 'Add Cycle',
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCycle()));
                  },
                  imagUrl:
                      'https://fliptoy.s3.ap-south-1.amazonaws.com/ssl-img/2021/01/14112443/foldble-26-t-cycle.jpg',
                ),
                MainWidget(
                  text: 'All Cycles',
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllCycles()));
                  },
                  imagUrl:
                      'https://images.squarespace-cdn.com/content/v1/5740a666356fb0ac05b2b01c/1485538403829-9E9F5Y59CW5BRZ7YKNFO/IMG_5692.jpg?format=1000w',
                ),
                MainWidget(
                  text: 'All Users',
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllUsers()));
                  },
                  imagUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNnOD2OkO4LHBhlTxO4H7yysLutHTFJLDZyQ&usqp=CAU',
                ),
                MainWidget(
                  text: 'All Orders',
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllOrders()));
                  },
                  imagUrl:
                      'https://1.bp.blogspot.com/--Bp9VRCVee4/XcxevdcQQkI/AAAAAAAAJuY/ousklgKLBicFRjdw6we1Z0zHnq9zk2cLwCLcBGAsYHQ/s1600/%25D9%2585%25D8%25AD%25D8%25A7%25D8%25AF%25D8%25AB%25D8%25A9%2B%25D8%25A8%25D8%25A7%25D9%2584%25D9%2584%25D8%25BA%25D8%25A9%2B%25D8%25A7%25D9%2584%25D8%25A7%25D9%2586%25D8%25AC%25D9%2584%25D9%258A%25D8%25B2%25D9%258A%25D8%25A9%2B%25D9%2581%25D9%2589%2B%25D8%25A7%25D9%2584%25D8%25B9%25D9%258A%25D8%25A7%25D8%25AF%25D8%25A9%2BIn%2Bthe%2Bclinic.PNG',
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

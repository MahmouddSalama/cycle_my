import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/auth_bottn.dart';
import 'package:cycle_my/screens/auth/screens/Regester_screen.dart';
import 'package:cycle_my/screens/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
class EntryToApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Center(
         child: Column(
           children: [
            const SizedBox(height: 100,),
             Text(
               "Cycle Me",
               style: TextStyle(
                 fontStyle: FontStyle.italic,
                 color: KmainColor.withOpacity(0.5),
                 fontSize: 50,
                 height: 1.2,
               ),
             ),
             const SizedBox(height: 20),
             SizedBox(
                 width: 500,
                 height: 280,
                 child: Image.asset(
                   "assets/image/logo.png",
                   fit: BoxFit.contain,
                 )),
             const SizedBox(height: 10,),
             AuthButton(title: 'SIGN UP', function: (){
               // go to register screen
               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
             }),
             AuthButton(title: 'LOG IN', function: (){
               // go to login screen
               Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
             }),
           ],
         ),
       ),
     ),
    );
  }
}

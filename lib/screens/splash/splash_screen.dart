import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/screens/entry_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EntryToApp()
      ));
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 20),
              buildPadding(text1:'Put the' ,text2:' SPORT' ),
              buildPadding(text1:'in', text2: ' TRANSPORT',x: 0),
              const SizedBox(height: 20,),
              CircularProgressIndicator(
                  strokeWidth: 8,
                color: KmainColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPadding({text1,text2,x=1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          x==0?const Spacer():const SizedBox(),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: text1,
                style: TextStyle(
                    fontSize: 45,
                    color: KswapColor1.withOpacity(.6),
                    fontStyle: FontStyle.italic),
              ),
              TextSpan(
                text: text2,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 45,
                  color: KswapColor2.withOpacity(.5),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

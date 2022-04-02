import 'package:cycle_my/screens/body/userbody/components/allow_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'currunt_location.dart';

class AllowAccessLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 60,
                      height: 70,
                      child: Image.asset(
                        "assets/image/logo.png",
                        fit: BoxFit.contain,
                      )),
                  const Text(
                    "Select Your Location",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Color(0xff424242)),
                  )
                ],
              ),
              const SizedBox(height: 60),
              const Text(
                "Allow \"CycleMe\" to access your location?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff5C5C5C), fontSize: 30),
              ),
              const SizedBox(height: 30),
              Builder(
                builder:(ctx)=> AllowLocationButton(
                  title: 'Allow',
                  function: () {
                    // ask to open location
                    //....
                    // go to map
                    Navigator.pushReplacement(ctx,
                        MaterialPageRoute(builder: (ctx) => currentLocation()));
                  },
                ),
              ),
              AllowLocationButton(
                title: 'Allow While Using App',
                function: () {
                  // ask to open location
                  //....
                  // go to map
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => currentLocation()));
                },
              ),
              AllowLocationButton(
                title: 'Allow Once',
                function: () {
                  // ask to open location
                  //....
                  // go to map
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => currentLocation()));
                },
              ),
              SizedBox(
                width: 500,
                height: 250,
                child: Image.asset(
                  "assets/image/cycle.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

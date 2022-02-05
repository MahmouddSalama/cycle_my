import 'dart:async';

import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:cycle_my/screens/body/userbody/screens/pay/chose_method.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Selectcycle extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );
  final Set<Marker> _marker1 = {
    Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(37.4399606, -122.088323),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      infoWindow: InfoWindow(
          title: 'my  Position is (37 ,-122)=>1',
          onTap: () {
            print("my  Position is (37 ,-122)=>1");
          }),
    ),
    Marker(
      markerId: const MarkerId('2'),
      position: const LatLng(37.49596, -122.088323),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
          title: 'my  Position is (37 ,-122)=>2',
          onTap: () {
            print("my  Position is (37 ,-122)=>2");
          }),
    ),
    Marker(
      markerId: const MarkerId('3'),
      position: const LatLng(37.43660, -122.08832357078792),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(
          title: 'my  Position is (37 ,-122)=>3',
          onTap: () {
            print("my  Position is (37 ,-122)=>3");
          }),
    ),
    Marker(
      markerId: const MarkerId('4'),
      position: const LatLng(37.4356068, -122.08832357078792),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: InfoWindow(
          title: 'my  Position is (37 ,-122)=> 4',
          onTap: () {
            print("my  Position is (37 ,-122)=>4");
          }),
    ),
  };
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -121.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _marker1,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          OrderButton(
            text: "CODE",
            function: () {
              // Enter the code of cycle
              //....
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: Stack(
                        overflow: Overflow.visible,
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
                              child: DefaultTextField(
                                label: "Cycle CODE",
                                validetor: (v) {

                                },
                                textEditingController: null,
                                textInputType: TextInputType.number,
                              )),

                          Positioned(
                            top: -100,
                            child: Image.asset("assets/image/logo.png",
                                width: 150, height: 150),
                          ),
                          Positioned(
                            bottom: 1,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // go to pay screen
                                //....
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChoseMethodOFPay()));
                              },
                              color: KmainColor,
                              child:const Text("OK",style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                          )
                        ],
                      ),
                    );
                  },
              );
            },
          ),
        ],
      ),
    );
  }
}

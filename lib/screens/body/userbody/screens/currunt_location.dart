import 'dart:async';

import 'package:cycle_my/screens/body/component/drawer/drawer_widget.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:cycle_my/screens/body/userbody/screens/select_cycle.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class currentLocation extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final Marker _marker1 = Marker(
    markerId: const MarkerId('1'),
    position: const LatLng(37.43296265331129, -122.08832357078792),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    infoWindow: InfoWindow(
        title: 'my  Position is (37 ,-122)',
        onTap: () {
          print("my  Position is (37 ,-122)");
        }),
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme:const IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title:const Text("Cycle Me",style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Stack(
        children: [
          Center(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {_marker1},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          OrderButton(text: "CONFIRM LOCATION",function: (){
            // go to chose cycle
            //....
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Selectcycle()));

          },),
        ],
      ),
    );
  }
}

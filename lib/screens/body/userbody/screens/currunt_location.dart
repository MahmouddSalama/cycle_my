import 'dart:async';

import 'package:cycle_my/screens/body/component/drawer/drawer_widget.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:cycle_my/screens/body/userbody/screens/select_cycle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class currentLocation extends StatefulWidget {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  State<currentLocation> createState() => _currentLocationState();
}

class _currentLocationState extends State<currentLocation> {
  late GoogleMapController _controller;

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
List<Marker> mark=[];
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Cycle Me",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: mark.toSet(),
              initialCameraPosition: currentLocation._kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller=controller;
                setState(() {});
              },
            ),
          ),
          OrderButton(
            text: "CONFIRM LOCATION",
            function: ()async {
              // go to chose cycle
              //....
              Position position = await currentlocation();
              _controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      zoom: 18.5,
                      target: LatLng(position.latitude, position.longitude))));
              mark.add( Marker(markerId: MarkerId('currentPosotion'),
                  position: LatLng(position.latitude, position.longitude),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Selectcycle()));
              }
              ));
              setState(() {});
            },
          ),
          Container(
            width: size.width,
            height: 30,
            alignment: Alignment.center,
            color: Colors.white,
            child: const Text('this is the current location',style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ],
      ),
    );
  }

  Future<Position> currentlocation() async {
    bool serviceEnabeld;
    LocationPermission locationPermission;
    serviceEnabeld = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabeld) {
      return Future.error(' the location is not enabeld');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error(' LocationPermission is denied');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(' LocationPermission deniedForever');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}

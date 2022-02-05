import 'dart:async';

import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AddCycle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('Add Cycle'),
      ),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DefaultTextField(
                label: 'Name',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              DefaultTextField(
                label: 'Model',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              DefaultTextField(
                label: 'Id',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              DefaultTextField(
                label: 'Color',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: SizedBox(
                        height:  400,
                        width: 400,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          markers: {_marker1},
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                    );

                  });
                },
                child: DefaultTextField(
                  enabled: false,
                  label: 'Location',
                  validetor: (v){},
                  textEditingController: null,
                  textInputType: TextInputType.name,
                ),
              ),
              const SizedBox(height: 20,),
              OrderButton(
                function: (){},
                text: 'Add',
              ),
            ],
          ),
        ),
      ),
    );
  }
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
}

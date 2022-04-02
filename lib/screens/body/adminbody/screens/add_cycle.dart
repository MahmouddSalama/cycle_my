import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/auth_logic/auth_state.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
class AddCycle extends StatefulWidget {
  @override
  State<AddCycle> createState() => _AddCycleState();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
}

class _AddCycleState extends State<AddCycle> {
  final TextEditingController name = TextEditingController();

  final TextEditingController model = TextEditingController();

  final TextEditingController id = TextEditingController();

  final TextEditingController color = TextEditingController();

  final TextEditingController location = TextEditingController();
  bool load = false;
  double lang = 0.0;

  double lat = 0.0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id.text = const Uuid().v4();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('Add Cycle'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DefaultTextField(
                  label: 'Name',
                  validetor: (v) {
                    if (v
                        .toString()
                        .isEmpty) {
                      return "enter valid name";
                    }
                  },
                  textEditingController: name,
                  textInputType: TextInputType.name,
                ),
                DefaultTextField(
                  label: 'Model',
                  validetor: (v) {
                    if (v
                        .toString()
                        .isEmpty) {
                      return "enter valid model";
                    }
                  },
                  textEditingController: model,
                  textInputType: TextInputType.number,
                ),
                DefaultTextField(
                  enabled: false,
                  label: 'Id',
                  validetor: (v) {
                    if (v
                        .toString()
                        .isEmpty) {
                      return "enter valid id";
                    }
                  },
                  textEditingController: id,
                  textInputType: TextInputType.name,
                ),
                DefaultTextField(
                  label: 'Color',
                  validetor: (v) {
                    if (v
                        .toString()
                        .isEmpty) {
                      return "enter valid color";
                    }
                  },
                  textEditingController: color,
                  textInputType: TextInputType.name,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: const Text('ok', style: TextStyle(
                              color: KmainColor
                          ),)),
                          TextButton(onPressed: () {
                            location.text = "";
                            setState(() {});
                            Navigator.pop(context);
                          }, child: const Text('cancel', style: TextStyle(
                              color: Colors.red
                          ),))
                        ],
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          height: 400,
                          width: 400,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            markers: {_marker1},
                            onTap: (pos) {
                              lang = pos.longitude;
                              lat = pos.latitude;
                              location.text = pos.toString();
                              setState(() {});
                            },
                            initialCameraPosition: AddCycle._kGooglePlex,
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
                    validetor: (v) {
                      if (v
                          .toString()
                          .isEmpty) {
                        return "chose valid location";
                      }
                    },
                    textEditingController: location,
                    textInputType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 20,),
                load
                    ? const Center(
                    child: CircularProgressIndicator(color: KmainColor,))
                    : OrderButton(
                  function: () {
                    addCycle();
                  },
                  text: 'Add',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Completer<GoogleMapController> _controller = Completer();
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

  addCycle() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        load = true;
      });
      try {
        await FirebaseFirestore.instance
            .collection('cycles')
            .doc(id.text)
            .set({
          'adminId': FirebaseAuth.instance.currentUser!.uid,
          'Name': name.text,
          'model': model.text,
          'id': id.text,
          'color':color.text,
          'createdAt': Timestamp.now(),
          'location':location.text ,
          'lang': lang,
          'lati': lat,
        }).then((value) {
          return showDialog(context: context, builder: (ctx) {
            return AlertDialog(
              content: SizedBox(
                width: 250,
                height: 250,
                child: BarcodeWidget(
                  data: id.text,
                  barcode: Barcode.qrCode(),
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(onPressed: () {
                  clear();
                  Navigator.pop(context);
                }, child: Text('ok')),
              ],
            );
          });
        });
        load = false;
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  clear(){
    name.clear();
    model.clear();
    id.clear();
    color.clear();
    location.clear();
   setState(() {

   });
  }
}

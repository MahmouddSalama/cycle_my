import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:cycle_my/screens/body/userbody/screens/pay/chose_method.dart';
import 'package:cycle_my/screens/body/userbody/screens/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Selectcycle extends StatefulWidget {
  final double lang;
  final double lat;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  const Selectcycle({Key? key,required this.lang,required this.lat}) : super(key: key);

  @override
State<Selectcycle> createState() => _SelectcycleState();
}

class _SelectcycleState extends State<Selectcycle> {
  String qrstr='';
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _marker1 = {
  };
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:  const Text('Choose the one closest to your location',style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('cycles').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                try{
                  final  docs = snapshot.data!.docs;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (snapshot.hasError) {
                    return const Center(child: Text("error"));
                  }
                  else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                    for(int i=0;i<docs.length;i++){
                      print(i);
                      _marker1.add(Marker(
                        markerId:  MarkerId('$i'),
                        position: LatLng(docs[i]['lati'],docs[i]['lang']),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                        infoWindow: InfoWindow(
                          title: 'cycleMe',
                            onTap: () {
                            if(distance(widget.lat,widget.lang,docs[i]['lati'] , docs[i]['lang'])>.5) {
                              showBottomSheet(context: context, builder: (context){
                                return Container(
                                  height:size.height*.6,
                                  width: size.width,
                                color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          width: 70,
                                          height: 90,
                                          child: Image.asset(
                                            "assets/image/logo.png",
                                            fit: BoxFit.contain,
                                          )),
                                      Text(
                                        "Cycle Me",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: KmainColor.withOpacity(0.5),
                                          fontSize: 20,
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                      const Text(
                                        "Kick Scouter",
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18,
                                          height: 1.2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children:  [
                                            IconButton(onPressed: (){}, icon: Icon(Icons.location_on)),
                                            const Text(
                                              " 15 minutes 7.5sr \n 30 minutes 15sr \n One hour 30 sr \n Every extra one  minutes with 0.5sr",
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 18,
                                                height: 1.2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      OrderButton(
                                        text: "scan",
                                        function: ()async{
                                          // Enter the code of cycle
                                          //....
                                          await scanCode().then((value) {
                                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderTimer(cycleID: qrstr,)));
                                          });
                                          print('qrstr');
                                          print(qrstr);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("This cycle is more than 500 meters away"),
                                  backgroundColor:KmainColor,
                                )
                              );
                            }
                            }),
                      ));

                    }
                    return Center(
                      child: GoogleMap(
                        mapType: MapType.normal,
                        markers: _marker1,
                        initialCameraPosition: Selectcycle._kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    );
                  }
                }catch(e){
                 print(e.toString());
                }
                return const Center(child: CircularProgressIndicator());
              }
          ),
        ],
      ),
    );
  }
  Future <void> scanCode()async{
  FlutterBarcodeScanner.scanBarcode('#060606', 'cancel', true, ScanMode.QR).then((value){
    qrstr=value;
    setState(() {});
  });
  }
  double distance( double lat1,  double long1,
   double lat2,  double long2)
  {
  lat1 = toRadians(lat1);
  long1 = toRadians(long1);
  lat2 = toRadians(lat2);
  long2 = toRadians(long2);
   var dlong = long2 - long1;
   var dlat = lat2 - lat1;
   var ans = pow(sin(dlat / 2), 2) +
  cos(lat1) * cos(lat2) *
  pow(sin(dlong / 2), 2);
  ans = 2 * asin(sqrt(ans));
   double R = 6371;
  ans = ans * R;

  return ans;
  }
}
double toRadians(ree)
{
  double one_deg = (pi) / 180;
  return (one_deg * ree);
}
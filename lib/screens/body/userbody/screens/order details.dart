import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../consts/colors.dart';

class OrderDetails extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String timer;
  final double price;
  final String cycleID;

  OrderDetails({Key? key,
    required this.startDate,
    required this.endDate,
    required this.timer,
    required this.price,
    required this.cycleID})
      : super(key: key);
  bool load = false;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Position? position;
  var rate;
  String id='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.black,
                  border: Border.all(color: KmainColor, width: 1.5),
                ),
                child: Column(
                  children: [
                    Container(
                      child: const Text(
                        "user name",
                        style: TextStyle(
                          fontSize: 18,
                          color: KmainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      height: 40,
                      alignment: Alignment.center,
                    ),
                    Divider(thickness: 2, color: KmainColor.withOpacity(.6)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildColumn(
                              text1: 'Day : ',
                              text2:
                              '${widget.startDate.year}/${widget.startDate
                                  .month}/${widget.startDate.day}'),
                          buildColumn(
                              text1: 'Time start : ',
                              text2:
                              "${widget.startDate.hour} : ${widget.startDate
                                  .minute}"),
                          buildColumn(
                              text1: 'Time end : ',
                              text2:
                              "${widget.endDate.hour} : ${widget.endDate
                                  .minute} "),
                          buildColumn(text1: 'Timer : ', text2: widget.timer),
                          buildColumn(text1: 'Price : ', text2: widget.price
                              .toString() + ' SR'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Text("Choose wallet",style: TextStyle(
            fontSize: 20,
              fontWeight: FontWeight.w700
            ),),
            Expanded(
              child:   StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('wallet').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          try {
            final List docs = snapshot.data!.docs
                .where((element) =>
            element['id'] ==
                FirebaseAuth.instance.currentUser!.uid)
                .toList();

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("error"));
            } else if (snapshot.hasData &&
                snapshot.data!.docs.length != 0) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap:(){
                            id=docs[index].id.toString();
                          },
                          title: Text(docs[index]['cridetNum'].toString()),
                          subtitle: Text(docs[index]['name']),
                          leading:  Icon(Icons.payment),
                          trailing: Text((index+1).toString()),
                        ),
                        Divider(color: KmainColor,thickness: 1.5),

                      ],
                    ),
                  );
                },
                itemCount: docs.length,
              );
            }
          } catch (e) {}
          return const Center(child: CircularProgressIndicator());
        }),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50,
                  vertical: 20),
              child: widget.load
                  ? const Center(
                child: CircularProgressIndicator(color: KmainColor,),)
                  : OrderButton(
                function: ()async {
                  order();
                },
                text: 'Pay',
              ),
            ),
              ]
            )
        ),
    );
  }

  Column buildColumn({text1, text2}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text1,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 18,
                color: KmainColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Divider(thickness: 1.5, color: KmainColor.withOpacity(.3)),
      ],
    );
  }

  order() async {
    widget.load = true;
    setState(() {});
    if(!id.isEmpty) {
      try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc()
          .set({
        'userID': FirebaseAuth.instance.currentUser!.uid,
        'startDate': widget.startDate,
        'endDate': widget.endDate,
        'timer': widget.timer,
        'price': widget.price,
        'createdAt': Timestamp.now(),
        'cycleId': widget.cycleID,
        'walletid':id,
        'accept': true,
      }).then((value) async {
        // await FirebaseFirestore.instance
        //     .collection('cycles')
        //     .doc(widget.cycleID).update({
        // 'lang':position?.longitude,
        // 'lati':position?.longitude,
        // 'location':LatLng(position!.latitude,position!.longitude).toString()
        // });
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 120,
                child: Column(
                  children: [
                    const Text("Rate Us",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                    ),),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        rate=rating;
                        setState(() {});
                      },
                    ),
                    TextButton( child: Text('Rate us'), onPressed: ()async{
                      await FirebaseFirestore.instance
                          .collection('rates')
                          .doc()
                          .set({
                        'userID': FirebaseAuth.instance.currentUser!.uid,
                        'rate':rate,
                        'createdAt': Timestamp.now(),
                      }).then((value){
                        Navigator.pop(context);
                      });
                    })
                  ],
                ),
              )
            );
          },
        ).then((value) {
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
                      height: 150,
                      child: Column(
                        children: const [
                          SizedBox(height: 60,),
                          Text("Thank you for using cycle me", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: KmainColor
                          ),),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -100,
                      child: Image.asset("assets/image/logo.png",
                          width: 150, height: 150),
                    ),
                    Positioned(
                      bottom: 1,
                      child: MaterialButton(
                        onPressed: () {
                          for (; Navigator.canPop(context);) {
                            Navigator.pop(context);
                          }
                        },
                        color: KmainColor,
                        child: const Text("OK", style: TextStyle(
                            color: Colors.white
                        ),),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
        widget.load = false;
        setState(() {});
      });
    } catch (e) {
      print(e.toString());
      widget.load = false;
      setState(() {});
    }
    }
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

import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/body/adminbody/screens/edit_cycle.dart';
import 'package:flutter/material.dart';
class AllCycles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('All Cycles'),
      ),
      body: Center(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return Padding(
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
                      child:const Text(
                        "name",
                        style: TextStyle(
                          fontSize: 18,
                          color: KmainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      height: 40,
                      alignment: Alignment.center,
                    ),
                    Divider(
                        thickness: 2,
                        color: KmainColor.withOpacity(.6)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          buildColumn(text1: 'Name : ', text2: 'Cycle'),
                          buildColumn(text1: 'Date : ', text2: "2-2-2022"),
                          buildColumn(text1: 'Model : ', text2:'Credit card'),
                          buildColumn(text1: 'Color : ', text2:'red'),
                          buildColumn(text1: 'Location : ', text2:'(x,y)'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(onPressed: ()async{
                                //  await FirebaseFirestore.instance.collection('orders').doc(docs[index].id).delete();
                              }, child:const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              )),
                              TextButton(onPressed: ()async{
                                // go to edit screen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditCycle()));
                              }, child:const Text(
                                'Edit',
                                style: TextStyle(color: Colors.green),
                              )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount:10,
        ),
      ),
    );
  }
  Column buildColumn({text1,text2}) {
    return Column(
      children: [

        Row(
          children: [
            Text(
              text1,
              style:const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              text2,
              style:const TextStyle(
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
}

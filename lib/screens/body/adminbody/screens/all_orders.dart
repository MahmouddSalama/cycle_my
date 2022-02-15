import 'package:cycle_my/consts/colors.dart';
import 'package:flutter/material.dart';
class AllOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title:const Text("All Orders"),
      ),
      body: Center(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
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
                          buildColumn(text1: 'Day : ', text2: '12-2-2020'),
                          buildColumn(text1: 'time : ', text2: "1PM"),
                          buildColumn(text1: 'price : ', text2: '50' +
                              ' SR'),
                          buildColumn(text1: 'Way of payment : ', text2:'Credit card'),
                          buildColumn(text1: 'Accept : ', text2:'true'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(onPressed: ()async{
                                //  await FirebaseFirestore.instance.collection('orders').doc(docs[index].id).delete();
                              }, child:const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              )),
                              TextButton(onPressed: ()async{
                                //  await FirebaseFirestore.instance.collection('orders').doc(docs[index].id).delete();
                              }, child:const Text(
                                'accept',
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

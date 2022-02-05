import 'package:cycle_my/consts/colors.dart';
import 'package:flutter/material.dart';
class AllUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('All users'),
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
                          buildColumn(text1: 'Name : ', text2: 'user name'),
                          buildColumn(text1: 'Date : ', text2: "2-2-2022"),
                          buildColumn(text1: 'email : ', text2:'email@gmial.com'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(onPressed: ()async{
                               // sent email
                              }, child:const Text(
                                'Connect',
                                style: TextStyle(color: Colors.black),
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
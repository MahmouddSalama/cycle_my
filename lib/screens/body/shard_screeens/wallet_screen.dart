import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'add_wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title:Text("My Wallet"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
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
                              Divider(
                                  thickness: 2,
                                  color: KmainColor.withOpacity(.6)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [  buildColumn(
                                      text1: 'Name : ', text2: docs[index]['name']),

                                    buildColumn(
                                        text1: 'Cridet number : ', text2: docs[index]['cridetNum']),
                                    buildColumn(
                                        text1: 'cvv : ',
                                        text2: docs[index]['cvv'].toString()),
                                    buildColumn(
                                        text1: 'YY : ',
                                        text2: docs[index]['yy'].toString()),
                                    buildColumn(
                                        text1: 'MM : ',
                                        text2: docs[index]['mm'].toString()),

                                  ],
                                ),
                              )
                            ],
                          ),
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
      floatingActionButton: Builder(
        builder: (ctx) {
          return FloatingActionButton(
            onPressed: (){
              showBottomSheet(
                  context: ctx,
                  builder: (ctx) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: AddWallet(),
                  )
              );
            },
            backgroundColor: KmainColor,
            child: const Icon(Icons.add),
          );
        }
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
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
                  child: Text(
                    "Wallet ${index+1}",
                    style: const TextStyle(
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
                      buildColumn(
                          text1: 'Day : ',
                          text2:
                          ''),
                      buildColumn(
                          text1: 'Time start : ',
                          text2:
                          ""),
                      buildColumn(
                          text1: 'Time end : ',
                          text2:
                          ""),
                      buildColumn(
                          text1: 'Timer : ', text2: ""),
                      buildColumn(
                          text1: 'Price : ',
                          text2: ""),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },

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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class AllUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('All users'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              try{
                final  docs = snapshot.data!.docs;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: KmainColor,));
                }
                else if (snapshot.hasError) {
                  return const Center(child: Text("error"));
                }
                else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                  return ListView.builder(
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
                                    buildColumn(text1: 'User Name : ', text2: docs[index]['userName']),
                                    buildColumn(text1: 'Full name : ', text2:docs[index]['fullName']),
                                    buildColumn(text1: 'phone : ', text2: docs[index]['phone']),
                                    buildColumn(text1: 'Date : ', text2: '${docs[index]['createdAt'].toDate().year.toString()} / ${docs[index]['createdAt'].toDate().month.toString()} / ${docs[index]['createdAt'].toDate().day.toString()}'),
                                    buildColumn(text1: 'email : ', text2:docs[index]['email']),
                                    buildColumn(text1: 'payMethod : ', text2:docs[index]['payMethod']),
                                    buildColumn(text1: 'Admin ? : ', text2: docs[index]['admin'].toString()),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(onPressed: ()async{
                                          // sent email
                                          goToMail(email: docs[index]['email']);
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
                    itemCount:docs.length,
                  );
                }
              }catch(e){}
              return const Center(child: CircularProgressIndicator(color: KmainColor,));
            }
        ),
      ),
    );
  }
  void goToMail({email}) async {
    String url = 'mailto:$email';
    await launch(url);
  }
  ListView buildListView() {
    return ListView.builder(
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/body/userbody/screens/currunt_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../body/adminbody/screens/home_screen.dart';
import '../../body/userbody/screens/allow_location_screen.dart';
import '../screens/entry_screen.dart';

class AuthState extends StatefulWidget {

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  bool admin=false;
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    buildStreamBuilder();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return EntryToApp();
          } else if (snapshot.hasData) {
            return LoadScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Some error happened'),
              ),
            );
          }
        },
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                try{
                  final  docs = snapshot.data!.docs.firstWhere((element) =>element['id']==FirebaseAuth.instance.currentUser!.uid);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: KmainColor,));
                  }
                  else if (snapshot.hasError) {
                    return const Center(child: Text("error"));
                  }
                  else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                    if(docs['admin']){
                      admin=true;
                      setState(() {

                      });
                    }
                    else {
                      admin=false;
                      setState(() {

                      });
                    }
                  }
                }catch(e){
                }
                return const SizedBox();
              },
            );
  }
}
 class LoadScreen extends StatefulWidget {
  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: StreamBuilder<QuerySnapshot>(
         stream: FirebaseFirestore.instance.collection('users').snapshots(),
         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
           try{
             final  docs = snapshot.data!.docs.firstWhere((element) =>element['id']==FirebaseAuth.instance.currentUser!.uid);
             if (snapshot.connectionState == ConnectionState.waiting) {
               return const Center(child: CircularProgressIndicator(color: KmainColor,));
             }
             else if (snapshot.hasError) {
               return const Center(child: Text("error"));
             }
             else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
               if(docs['admin']==true){
                 return HomeAdminScreen();
               }
               else if(docs['admin']==false) {
                return currentLocation();
               }
               else{
                 return const Center(child: CircularProgressIndicator(color: KmainColor,));
               }
             }
           }catch(e){
           }
           return const Center(child: CircularProgressIndicator(color: KmainColor,));
         },
       ),
     );
   }
}


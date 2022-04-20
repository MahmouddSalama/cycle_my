import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UserAccount extends StatelessWidget {
  Color color = KmainColor;
  bool is_vis = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              try{
                final  docs = snapshot.data!.docs.firstWhere((element) =>element.id==FirebaseAuth.instance.currentUser!.uid);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: KmainColor,));
                }
                else if (snapshot.hasError) {
                  return const Center(child: Text("error"));
                }
                else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                  return  Column(
                    children: [
                      buildContainerHead(size),
                      SizedBox(height: size.height * .01),
                      buildTextfiled(docs['userName'], Icons.person_outline, 0),
                      buildTextfiled(docs['fullName'], Icons.person_sharp, 0),
                      buildTextfiled(docs['email'], Icons.email_outlined, 0),
                      buildTextfiled(docs['phone'], Icons.call, 0),
                      buildTextfiled(docs['password'], Icons.lock, 1),
                      const SizedBox(height: 20),
                      Container(
                        width: 200,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              color,
                              color.withOpacity(.6),
                            ])),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:const Text(
                            'OK',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }catch(e){}
              return const Center(child: CircularProgressIndicator(color: KmainColor,));
            }
        ),
      ),
    );
  }



  Padding buildTextfiled(text, icon, num) {
    Color c = Colors.green;
    return Padding(
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: TextFormField(
        onChanged: (value) {},
        obscureText: num == 1 ? is_vis : false,
        decoration: InputDecoration(
          suffixIcon: num == 1
              ? IconButton(
            onPressed: () {
              // setState(() {
              //   is_vis = !is_vis;
              // });
            },
            icon: Icon(
              is_vis ? Icons.visibility : Icons.visibility_off,
              size: 30,
              color: is_vis ? color : c,
            ),
          )
              : null,
          contentPadding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 25, left: 10),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          labelText: text,
        ),
      ),
    );
  }

  Container buildContainerHead(Size size) {
    return Container(
      height: size.height * .38,
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height * .3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [color, color.withOpacity(.5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                width: size.width * .31,
                height: size.height * .17,
                decoration:const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_sharp,
                  color: color,
                  size: 100,
                )),
          ),
         const Align(
            child: Text(
              "User Name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            alignment: Alignment(0, -0.2),
          ),
        ],
      ),
    );
  }
}

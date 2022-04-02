import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/auth_logic/auth_logic.dart';
import 'package:cycle_my/screens/auth/component/auth_bottn.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/auth/screens/foget_pass.dart';
import 'package:cycle_my/screens/body/adminbody/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../component/togel.dart';
import 'Regester_screen.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController pass = TextEditingController();
  bool load = false;
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 60,
                        height: 70,
                        child: Image.asset(
                          "assets/image/logo.png",
                          fit: BoxFit.contain,
                        )),
                    const Text(
                      "LOG  IN",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextField(
                  label: 'Email',
                  validetor: (v) {
                    if (v.toString().isEmpty ||
                        !v.toString().contains('@gmail.com')) {
                      return 'Enter valid email address';
                    }
                  },
                  textEditingController: email,
                  textInputType: TextInputType.emailAddress,
                ),
                DefaultTextField(
                  label: 'Password',
                  validetor: (v) {
                    if (v.toString().isEmpty || v.toString().length < 7) {
                      return 'pass must biger than 7 chars';
                    }
                  },
                  isPass: true,
                  textEditingController: pass,
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
               load?const Center(child: CircularProgressIndicator(color: KmainColor,),): AuthButton(
                    title: "LOG IN",
                    function: () {
                      // go to allow access
                    login();
                    }),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // go to forget my pass screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ForgetPass()));
                  },
                  child: const Text(
                    "Forget My Password?",
                    style: TextStyle(color: Color(0xff5C5C5C), fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TogelText(
                  qustion: 'New Cyclists? ',
                  operation: 'Create An account',
                  function: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  login(){
    if(_formKey.currentState!.validate()){
      setState(() {
        load = true;
      });
      AuthLogic.Login(context, email: email.text.trim(), pass: pass.text.trim())
          .then((value) {
        setState(() {
          load = false;
        });
      }).onError((error, stackTrace) {
        print(error);
      });
    }
  }
}

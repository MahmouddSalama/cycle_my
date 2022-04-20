import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/auth_logic/auth_logic.dart';
import 'package:cycle_my/screens/auth/component/auth_bottn.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/auth/screens/pdf.dart';
import 'package:cycle_my/screens/body/userbody/screens/allow_location_screen.dart';
import 'package:flutter/material.dart';

import '../component/togel.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController fullname = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final TextEditingController pass = TextEditingController();
  bool load = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  int payGroup = 0;
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
                      "SIGN  UP",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                  label: 'Username',
                  validetor: (v) {
                    if (v.toString().isEmpty) {
                      return 'Enter valid user name';
                    }
                  },
                  textEditingController: name,
                  textInputType: TextInputType.name,
                ),
                DefaultTextField(
                  label: 'Full Name',
                  validetor: (v) {
                    if (v.toString().isEmpty) {
                      return 'Enter valid  name';
                    }
                  },
                  textEditingController: fullname,
                  textInputType: TextInputType.name,
                ),
                DefaultTextField(
                  label: 'Phone',
                  validetor: (v) {
                    if (v.toString().isEmpty || v.toString().length != 11) {
                      return 'Enter valid phone';
                    }
                  },
                  textEditingController: phone,
                  textInputType: TextInputType.phone,
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
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    TogelText(
                      qustion: '',
                      operation: 'Privacy policy',
                      function:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => InFo(pdfPath: 'assets/pdf/policy.pdf',title: 'Privacy policy',)));
                      },
                    ),
                  ],
                ),
                load
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: KmainColor,
                        ),
                      )
                    : AuthButton(
                        title: "SIGN UP",
                        function: () {
                          // go to allow access
                         signup();
                          // HomeScreen
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }

  signup() {
    if (_formKey.currentState!.validate()&&isChecked==true) {
      setState(() {
        load = true;
      });
      AuthLogic.Register(
        context,
        email: email.text,
        pass: pass.text,
        userName: name.text,
        phone: phone.text,
        fullName: fullname.text,
      ) .then((value) {
        setState(() {
          load = false;
        });
      }).onError((error, stackTrace) {
        print(error);
      });
    }
  }
}

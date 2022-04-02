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
  final TextEditingController number= TextEditingController();

  final TextEditingController mm= TextEditingController();

  final TextEditingController yy= TextEditingController();

  final TextEditingController cvv= TextEditingController();

  final TextEditingController namec= TextEditingController();
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal:15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Payment Method',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(value: 0, groupValue: payGroup, onChanged: (n){
                          setState(() {
                            payGroup = int.parse(n.toString());
                          });
                        }),
                        const Text(
                          'Credit',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: 1, groupValue: payGroup, onChanged: (n){
                          setState(() {
                            payGroup = int.parse(n.toString());
                          });
                        }),
                        const Text(
                          'Debit',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                DefaultTextField(
                  validetor: (v) {
                    if(v.toString().isEmpty||v.toString().length!=16){
                      return 'enter valid number';
                    }
                  },
                  label: 'Credit card number',
                  textEditingController: number,
                  textInputType: TextInputType.number,
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultTextField(
                        validetor: (v) {
                          if(v.toString().isEmpty){
                            return 'enter valid MM';
                          }
                        },
                        label: 'validate',
                        hint: "MM",
                        textEditingController: mm,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Flexible(
                      child: DefaultTextField(
                        validetor: (v) {
                          if(v.toString().isEmpty){
                            return 'enter valid YY';
                          }
                        },
                        label: '',
                        hint: 'YY',
                        textEditingController: yy,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: DefaultTextField(
                        hint: "***",
                        validetor: (v) {
                          if(v.toString().isEmpty||v.toString().length!=3){
                            return 'enter valid cvv';
                          }
                        },
                        label: 'cvv',
                        textEditingController: cvv,
                        textInputType: TextInputType.name,
                      ),
                    )
                  ],
                ),
                DefaultTextField(
                  validetor: (v) {
                    if(v.toString().isEmpty){
                      return 'enter valid name';
                    }
                  },
                  label: "Credit holder's name",
                  textEditingController: namec,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
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
        cridetName: namec.text,
        cridetNum: number.text,
        cvv: cvv.text,
        mm: mm.text,
        payMethod: payGroup,
        yy: yy.text
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

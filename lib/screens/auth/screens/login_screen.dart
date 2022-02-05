import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/auth_bottn.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/auth/screens/foget_pass.dart';
import 'package:cycle_my/screens/body/adminbody/screens/home_screen.dart';
import 'package:cycle_my/screens/body/userbody/screens/allow_location_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  SizedBox(
                      width: 60,
                      height: 70,
                      child: Image.asset(
                        "assets/image/logo.png",
                        fit: BoxFit.contain,
                      )),
                  const Text("LOG  IN",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30
                  ),)
                ],
              ),
              const SizedBox(height: 20,),
              const SizedBox(height: 10,),
              DefaultTextField(
                label: 'Username',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              DefaultTextField(
                label: 'Password',
                validetor: (v){},
                isPass: true,
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 20,),
              AuthButton(title: "LOG IN", function: (){
                // go to allow access
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeAdminScreen()));

              }),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  // go to forget my pass screen
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPass()));

                },
                child:const Text(
          "Forget My Password?",
          style:
          TextStyle(color: Color(0xff5C5C5C), fontSize: 20),
        ),
        ),
               const SizedBox(height: 20,),
               TogelText(qustion: 'New Cyclists? ',operation: 'Create An account',function: (){},),
            ],
          ),
        ),
      ),
    );
  }
}
class TogelText extends StatelessWidget {
  final String qustion;
  final String operation;
  final Function function;


  const TogelText({Key? key,required this.qustion,required this.operation,required this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: '$qustion',
            style:const TextStyle(fontSize: 18, color: Color(0xff5C5C5C))),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () => function(),
          text: operation,
          style:const TextStyle(
              fontSize: 18,
              color: KmainColor,
              ),
        ),
      ]),
    );
  }
}
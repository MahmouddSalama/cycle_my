import 'package:cycle_my/screens/auth/component/auth_bottn.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/screens/allow_location_screen.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatelessWidget {
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
                  const Text("SIGN  UP",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30
                  ),)
                ],
              ),
              const SizedBox(height: 10,),
              DefaultTextField(
                label: 'Username',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.emailAddress,
              ),
              DefaultTextField(
                label: 'Full Name',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              DefaultTextField(
                label: 'Phone',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.phone,
              ),
              DefaultTextField(
                label: 'Password',
                validetor: (v){},
                isPass: true,
                textEditingController: null,
                textInputType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20,),
              AuthButton(title: "SIGN UP", function: (){
                // go to allow access
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AllowAccessLocation()));
                // HomeScreen
              })
            ],
          ),
        ),
      ),
    );
  }
}

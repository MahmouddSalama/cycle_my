import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/auth_bottn.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text("Forget my Password"),
      ),
      body: Center(
        child: Column(

          children: [
            const SizedBox(height: 100,),
            DefaultTextField(
              label: 'Enter your Email Address',
              validetor: (n){},
              textEditingController: null,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30,),
            AuthButton(title: 'ReSet', function: (){
              // go to FireBase to reset
            })
          ],
        ),
      ),
    );
  }
}

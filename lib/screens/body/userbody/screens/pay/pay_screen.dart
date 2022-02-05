import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/heder_of_pay_screen.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const HeadOFPayScreen(
                title: "Enter card details",
              ),
              const SizedBox(
                height: 30,
              ),
              DefaultTextField(
                validetor: (v) {},
                label: 'Credit card number',
                textEditingController: null,
                textInputType: TextInputType.number,
              ),
              Row(
                children: [
                  Flexible(
                    child: DefaultTextField(
                      validetor: (v) {},
                      label: 'valid th',
                      hint: "MM",
                      textEditingController: null,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  Flexible(
                    child: DefaultTextField(
                      validetor: (v) {},
                      label: '',
                      hint: 'YY',
                      textEditingController: null,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: DefaultTextField(
                      hint: "****",
                      validetor: (v) {},
                      label: 'cvv',
                      textEditingController: null,
                      textInputType: TextInputType.name,
                    ),
                  )
                ],
              ),
              DefaultTextField(
                validetor: (v) {},
                label: "Credit holder's name",
                textEditingController: null,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 35,
              ),
              OrderButton(
                  text: 'Pay now',
                  function: () {
                    // pay
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                height: 150,
                                child: Column(
                                  children:const [
                                    SizedBox(height: 60,),
                                    Text("All Done",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                      color: KmainColor
                                    ),),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -100,
                                child: Image.asset("assets/image/logo.png",
                                    width: 150, height: 150),
                              ),
                              Positioned(
                                bottom: 1,
                                child: MaterialButton(
                                  onPressed: () {
                                    for(;Navigator.canPop(context);){
                                      Navigator.pop(context);
                                    }
                                  },
                                  color: KmainColor,
                                  child:const Text("OK",style: TextStyle(
                                      color: Colors.white
                                  ),),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );

                  }),
            ],
          ),
        ),
      ),
    );
  }
}

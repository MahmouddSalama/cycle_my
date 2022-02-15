import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/body/userbody/components/heder_of_pay_screen.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:cycle_my/screens/body/userbody/screens/pay/pay_screen.dart';
import 'package:flutter/material.dart';

class ChoseMethodOFPay extends StatefulWidget {
  @override
  State<ChoseMethodOFPay> createState() => _ChoseMethodOFPayState();
}

class _ChoseMethodOFPayState extends State<ChoseMethodOFPay> {
  int payGroup = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HeadOFPayScreen(
                title: "payment  method",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Column(
                      children: [
                        buildColumn(
                            iconData: Icons.payment_outlined,
                            title: "Credit Card",
                            valu: 1),
                        buildColumn(
                            iconData: Icons.soap, title: "Paypal", valu: 2),

                        const SizedBox(
                          height: 35,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              OrderButton(
                  text: 'Continue',
                  function: () {
                    if (payGroup == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                          Text("Chose Method to pay and continue",style: TextStyle(
                              fontSize: 18
                          ),),
                          backgroundColor: KmainColor,
                        ),
                      );
                    }else{
                      // go to pay screen
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PayScreen()));

                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumn({
    required IconData iconData,
    required String title,
    required int valu,
    x = 0,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Icon(
                iconData,
                color: const Color(0xff3E4C67),
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Color(0xff9A9BAC),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Radio(
                value: valu,
                groupValue: payGroup,
                onChanged: (n) {
                  setState(() {
                    payGroup = int.parse(n.toString());
                  });
                },
                activeColor: KmainColor,
                hoverColor: const Color(0xff9A9BAC),
              ),
            ],
          ),
        ),
        if (x == 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Divider(
              color: Color(0xff3E4C67).withOpacity(.3),
              thickness: 1.5,
            ),
          ),
      ],
    );
  }
}

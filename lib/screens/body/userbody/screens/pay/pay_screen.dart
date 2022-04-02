import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/heder_of_pay_screen.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  final String cycleCode;
  final int pay;
  bool load =false;
  final _formKey=GlobalKey<FormState>();
   PayScreen({Key? key,required this.cycleCode,required this.pay}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {

  final TextEditingController number= TextEditingController();

  final TextEditingController mm= TextEditingController();

  final TextEditingController yy= TextEditingController();

  final TextEditingController cvv= TextEditingController();

  final TextEditingController name= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: widget._formKey,
            child: Column(
              children: [
                const HeadOFPayScreen(
                  title: "Enter card details",
                ),
                const SizedBox(
                  height: 30,
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
                        label: 'valid th',
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
                        hint: "****",
                        validetor: (v) {
                          if(v.toString().isEmpty){
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
                  textEditingController: name,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 35,
                ),
            widget.load? const Center(child:  CircularProgressIndicator(color: KmainColor,),):  OrderButton(
                    text: 'Pay now',
                    function: () {
                      // pay
                      order();
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  order()async{
    if(widget._formKey.currentState!.validate()){
      widget.load=true;
      setState(() {});
      try{
        await FirebaseFirestore.instance
            .collection('orders')
            .doc()
            .set({
          'userID': FirebaseAuth.instance.currentUser!.uid,
          'Name': name.text,
          'createdAt': Timestamp.now(),
          'mm':mm.text,
          'yy':yy.text,
          'cvv':cvv.text,
          'cridetNum':number.text,
          'payMethod':widget.pay==1?'credit':'paypal',
          'cycleId':widget.cycleCode,
          'accept':true,
        }).then((value) {
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
          widget.load=false;
          setState(() {});
        });
      }catch(e){
        print(e.toString());
        widget.load=false;
        setState(() {});
      }
    }
  }
}

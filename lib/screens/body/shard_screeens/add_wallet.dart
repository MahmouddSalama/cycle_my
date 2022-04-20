

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/component/default_text_field.dart';
import '../../auth/screens/pdf.dart';
class AddWallet extends StatefulWidget {
  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
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

    return Container(
      height:MediaQuery.of(context).size.height*.7,
      child: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(

              children: [
                AppBar(
                  backgroundColor: KmainColor,
                  title: Text("Add Wallet"),
                ),
                SizedBox(height:20,),
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
               load?Center(child: CircularProgressIndicator(color: KmainColor,)) : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: OrderButton(
                    function: (){
                      addwallet();
                    },
                    text: 'Add',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  addwallet()async{
    try {

     setState(() {
       load=true;
     });
      await FirebaseFirestore.instance
          .collection('wallet')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'mm': mm.text,
        'yy': yy.text,
        'cvv': cvv.text,
        'cridetNum': number.text,
        'payMethod': payGroup == 1 ? 'credit' : 'paypal',
        'name':namec.text
      }).then((value) {
        setState(() {
          load=false;
        });
        mm.clear();
        cvv.clear();
        mm.clear();
        number.clear();
        namec.clear();
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        load=false;
      });
      print(e);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('InValid data'),
            content: Text(
              e.toString(),
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok'))
            ],
          ));
    } catch (e) {
      setState(() {
        load=false;
      });
      print(e);
    }
  }
}

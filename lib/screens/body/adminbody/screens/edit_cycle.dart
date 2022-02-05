import 'package:cycle_my/consts/colors.dart';
import 'package:cycle_my/screens/auth/component/default_text_field.dart';
import 'package:cycle_my/screens/body/userbody/components/order_button.dart';
import 'package:flutter/material.dart';
class EditCycle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KmainColor,
        title: const Text('Edit Cycle'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              SizedBox(
                  width: 500,
                  height: 100,
                  child: Image.asset(
                    "assets/image/logo.png",
                    fit: BoxFit.contain,
                  )),
              DefaultTextField(
                label: 'Name',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              DefaultTextField(
                label: 'Model',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),

              DefaultTextField(
                label: 'Color',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              DefaultTextField(
                label: 'Location',
                validetor: (v){},
                textEditingController: null,
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                 const SizedBox(width: 15,),
                  Flexible(
                    flex: 1,
                    child: OrderButton(
                      function: (){},
                      text: 'Delete',
                      color:  Colors.red,
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Flexible(
                    flex:  2,
                    child: OrderButton(
                      function: (){},
                      text: 'Add',
                    ),
                  ),
                  const SizedBox(width: 15,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

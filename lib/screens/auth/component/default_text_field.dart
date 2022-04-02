import 'package:cycle_my/consts/colors.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String label;
  final String? Function(dynamic value) validetor;
  final bool? isPass;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final bool? enabled;
  final String? hint;
  const DefaultTextField(
      {Key? key,
        this.enabled=true,
        this.textInputType=TextInputType.text,
        required this.label,
        required this.validetor,
        this.isPass = false,
        required this.textEditingController,
        this.focusNode,
        this.hint,
        this.nextFocusNode,
        this.textInputAction=TextInputAction.next,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style:const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),),
          const SizedBox(height: 5,),
          TextFormField(
            enabled: enabled,
            focusNode: focusNode,
            textInputAction: textInputAction,
            onEditingComplete: (){
              if (nextFocusNode!=null)
              {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
              if(textInputAction== TextInputAction.done)
                FocusScope.of(context).unfocus();
            },

            cursorColor: KmainColor,
            style:const TextStyle(fontSize: 20, color: Colors.black),
            keyboardType: textInputType,
            validator: (v) => validetor(v),
            obscureText: isPass!,
            controller:textEditingController,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                disabledBorder: buildUnderlineInputBorder(KmainColor),
                enabledBorder: buildUnderlineInputBorder(KmainColor),
                focusedBorder: buildUnderlineInputBorder(KmainColor),
                errorBorder: buildUnderlineInputBorder(Colors.red),
            ),

          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildUnderlineInputBorder(color) {
    return OutlineInputBorder (
      borderSide: BorderSide(color: color, width: 2),
    );
  }
}

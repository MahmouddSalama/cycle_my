import 'package:cycle_my/consts/colors.dart';
import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  final String text;
  final Function function;
  final Color color;

  const OrderButton({
    Key? key,
    required this.text,
    required this.function,
    this.color =KmainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, .98),
      child: GestureDetector(
        onTap: ()=>function(),
        child: Container(
          width: 350,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          alignment: Alignment.center,
          child:  Text(
            text,
            style:const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

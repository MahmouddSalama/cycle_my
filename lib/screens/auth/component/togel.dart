import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../consts/colors.dart';
class TogelText extends StatelessWidget {
  final String qustion;
  final String operation;
  final Function function;

  const TogelText(
      {Key? key,
        required this.qustion,
        required this.operation,
        required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: '$qustion',
            style: const TextStyle(fontSize: 18, color: Color(0xff5C5C5C))),
        TextSpan(
          recognizer: TapGestureRecognizer()..onTap = () => function(),
          text: operation,
          style: const TextStyle(
              color: Color(0xff416B53),
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
      ]),
    );
  }
}
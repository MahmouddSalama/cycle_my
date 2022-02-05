import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final Function function;


  const AuthButton({Key? key, required this.title, required this.function,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>function(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffB0EDC6),
                  Color(0xffCEE9DB)
                ],
              )
          ),
          child:  Text(title, style:const TextStyle(
              color: Color(0xff416B53),
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}

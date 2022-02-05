import 'package:flutter/material.dart';

class AllowLocationButton extends StatelessWidget {
  final String title;
  final Function function;

  const AllowLocationButton({
    Key? key,
    required this.title,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: ()=>function(),
        child: Container(
          width: 350,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xff424242), width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: const Color(0xff424242).withOpacity(.7)),
          ),
        ),
      ),
    );
  }
}

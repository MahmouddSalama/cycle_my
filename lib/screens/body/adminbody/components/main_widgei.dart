import 'package:cycle_my/consts/colors.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  final Function function;
  final String text;
  //final String imagUrl;

  const MainWidget({
    Key? key,
    required this.function,
    required this.text,
    //required this.imagUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          width: size.width,
          height: size.height * .15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Colors.green.withOpacity(.8),
                KmainColor,
              ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             //  Padding(
              //              //    padding:
              //              //        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //              //    child: SizedBox(
              //              //      child: ClipRRect(
              //              //        borderRadius: BorderRadius.circular(10),
              //              //      ),
              //              //      width: 110,
              //              //      height: size.height * .15,
              //              //    ),
              //              //  ),
              //              // const SizedBox(width: 20,),
              Text(
                text,
                style:const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
class HeadOFPayScreen extends StatelessWidget {
  final String title;

  const HeadOFPayScreen({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 25,
                )),
            const Spacer(),
             Text(
              title,
              style:const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Color(0xff3E4C67)),
            ),
            const Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: Divider(color: Color(0xff3E4C67).withOpacity(.3),thickness: 1.5,),
        ),
      ],
    );
  }
}

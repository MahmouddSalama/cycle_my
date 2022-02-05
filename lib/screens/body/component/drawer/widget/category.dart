
import 'package:cycle_my/consts/colors.dart';
import 'package:flutter/material.dart';

class CategoryListTileGarage extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function function;

  const CategoryListTileGarage({
    Key? key,
   required this.text,
   required this.iconData,
   required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>function(),
      title: Text(
        text,
        style:const TextStyle(
          color: KmainColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing:const Icon(
        Icons.arrow_forward_ios_outlined,
        color: KmainColor,
        size: 25,
      ),
      leading: Icon(
        iconData,
        color: KmainColor,
        size: 25,
      ),
    );
  }
}

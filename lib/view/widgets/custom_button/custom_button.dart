
import 'package:flutter/material.dart';

import '../custom_text/custom_text.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        this.height = 48,
        this.width = double.maxFinite,
        required this.onTap,
        this.title = 'Get Started',
        this.titleColor = Colors.black,
        this.marginVerticel = 0,
        this.marginHorizontal = 0, this.backgroundColor=Colors.green,this.fillColor=Colors.green });

  final double height;
  final double width;

  final VoidCallback onTap;

  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final Color fillColor;

  final double marginVerticel;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: marginVerticel, horizontal: marginHorizontal),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1,color: fillColor),
            color: backgroundColor),
        child: CustomText(
            fontWeight: FontWeight.w500,
            color: titleColor,
            textAlign: TextAlign.center,
            text: title),
      ),
    );
  }
}
//

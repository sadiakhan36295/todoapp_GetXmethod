
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textDecorationColor,
    this.textDecoration,
    this.text = "",
    this.lineHeight =0,
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final double lineHeight;
  final FontWeight fontWeight;
  final Color? color;
  final Color? textDecorationColor;
  final TextDecoration? textDecoration;
  final String text;
  final TextAlign textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom
      ),
      child: Text(

        textAlign: textAlign,
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style:TextStyle(
          height: lineHeight,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Theme.of(context).primaryColorLight,
          decoration: textDecoration,
          decorationColor:textDecorationColor,
          decorationStyle: TextDecorationStyle.solid,
        ),
      ),
    );
  }
}

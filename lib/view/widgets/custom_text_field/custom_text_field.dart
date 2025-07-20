
import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  static void _defaultOnTap() {}
  const CustomTextField({
    this.textEditingController,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = Colors.black,

    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.validator,
    this.hintText,
    this.textColor,
    this.fillColor = Colors.transparent,
    this.suffixIcon,
    this.onChanged,
    this.suffixIconColor,
    this.borderRadius = 8,
    this.fieldBorderColor,
    this.isPassword = false,
    this.readOnly = false,
    super.key,
    this.onTapClick = _defaultOnTap,
    this.isPrefixIcon = false,
    this.focusBorderColor ,
    this.height = 48,
    this.maxLength,
    this.labelText = '',
    this.onFieldSubmitted, this.isTextColor=false,
  });

  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;

  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final int? maxLength;
  final FormFieldValidator? validator;
  final String? hintText;
  final String labelText;
  final Color? fillColor;
  final Color? textColor;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final double borderRadius;
  final Color ?fieldBorderColor;
  final Color? focusBorderColor;
  final void Function(String)? onChanged;
  final bool isPassword;
  final bool isPrefixIcon;
  final VoidCallback onTapClick;
  final bool readOnly;
  final double height;
  final bool isTextColor;
  final void Function(String)? onFieldSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(0),
        child: TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: () {
            widget.onTapClick();
          },
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: widget.readOnly,
          controller: widget.textEditingController,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: widget.cursorColor,
          style: TextStyle(
              color:  widget.isTextColor ?widget.textColor: Theme.of(context).primaryColorLight
          ),
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          obscureText: widget.isPassword ? obscureText : false,
          validator: widget.validator,
          decoration: InputDecoration(
            isDense: true,
            errorMaxLines: 2,
            hintText: widget.hintText,

            hintStyle:const TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.w400
            ), // TextStyle(color: AppColors.blueLightActive),
            fillColor: widget.fillColor,
            filled: true,


            prefixIcon: widget.isPrefixIcon
                ? Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 0, vertical: 0),
              child: Icon(
                Icons.search,
                color: Colors.black26,
                size: 24,
              ),
            )
                : null,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                onTap: toggle,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16, vertical: 14),
                  child: obscureText
                      ?   Icon(
                    Icons.visibility_off_outlined,
                    color: Theme.of(context).primaryColorDark,
                  )
                      :   Icon(Icons.visibility_outlined,
                      color: Theme.of(context).primaryColorDark),
                ))
                : widget.suffixIcon,
            suffixIconColor: widget.suffixIconColor,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                BorderSide(color: widget.fieldBorderColor ?? Colors.black, width: 1),
                gapPadding: 0),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                BorderSide(color: widget.focusBorderColor ?? Colors.black, width: 1),
                gapPadding: 0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                BorderSide(color: widget.fieldBorderColor ?? Colors.black, width: 1),
                gapPadding: 0),
          ),
        ),
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}

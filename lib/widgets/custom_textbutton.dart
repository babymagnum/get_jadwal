import 'package:flutter/material.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.onPressed,
    this.text,
    this.textWidget,
    this.buttonColor,
    this.shape,
    this.minimumSize,
    this.textColor = Colors.white,
    this.borderColor,
    this.isUseUnderline = false,
    this.padding
  }) : super(key: key);
  final void Function()? onPressed;
  final String? text;
  final Widget? textWidget;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final RoundedRectangleBorder? shape;
  final double? minimumSize;
  final bool isUseUnderline;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Center(
        child: textWidget ??
            Text(
              text ?? '',
              style: ThemeText.poppinsBold.copyWith(
                color: textColor,
                decoration: isUseUnderline ? TextDecoration.underline : null,
              ),
              textAlign: TextAlign.center,
            ),
      ),
      style: TextButton.styleFrom(
        padding: padding,
        shape: shape,
        side: BorderSide(
          color: borderColor ?? (onPressed != null ? ThemeColor.purple : ThemeColor.grey),
        ),
        backgroundColor:
            buttonColor ?? (onPressed != null ? ThemeColor.purple : ThemeColor.grey),
        // minimumSize: Size(double.infinity, minimumSize ?? 50),
      ),
    );
  }
}

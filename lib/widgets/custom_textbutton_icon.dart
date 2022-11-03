import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';

class CustomTextButtonIcon extends StatelessWidget {
  final String text;
  final bool isSvg;
  final IconData? iconData;
  final String? icon;
  final Function() onPressed;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double borderWidth;
  final Color? textColor;
  final Color? iconColor;
  final bool isCenterTitle;
  final double borderRadius;
  final double iconSize;

  const CustomTextButtonIcon({
    Key? key,
    this.padding,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isSvg = false,
    this.backgroundColor,
    this.borderWidth = 1,
    this.textColor,
    this.iconData,
    this.iconColor,
    this.isCenterTitle = false,
    this.borderRadius = 1000,
    this.iconSize = 24
  }) : super(key: key);

  Widget get _text {
    return Text(
      text,
      style: ThemeText.poppinsSemiBold
          .copyWith(color: textColor ?? const Color(0xff111111)),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderWidth == 0 ? Colors.transparent : ThemeColor.purple,
            width: 1,
          ),
        ),
        backgroundColor: backgroundColor ?? Colors.white,
        // minimumSize: Size(double.infinity, minimumSize ?? 50),
      ),
      icon: iconData != null ?
      Icon(
        iconData!,
        size: iconSize,
        color: iconColor,
      ) :
      icon != null ?
      isSvg ?
      SvgPicture.asset(
        icon!,
        width: 16,
        height: 16,
      ) :
      Image.asset(
        icon!,
        width: 16,
        height: 16,
      ) :
      Container(),
      label: Container(
        transform: Matrix4.translationValues(-6.0, 0, 0.0),
        child: isCenterTitle
            ? Row(
                children: [
                  Expanded(
                    child: _text,
                  ),
                ],
              )
            : _text,
      ),
    );
  }
}

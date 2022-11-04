import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.validators,
    this.hint,
    this.enabled,
    this.maxLines,
    this.minLines,
    this.inputFormatter,
    this.prefix,
    this.suffixIcon,
    this.style,
    this.onChanged,
    this.obscure,
    this.onEditingComplete,
    this.inputAction = TextInputAction.next,
    this.errorText,
    this.isDense = true,
    this.initialValue,
    this.border,
    this.focusNode,
    this.textInputType,
    this.fillColor,
    this.maxLength,
    this.padding,
    this.textAlign,
    this.hideErrorText = false,
    this.autovalidateMode,
    this.hideCounter = true, this.onTap, this.readOnly = false,
    this.borderRadius = 6
  }) : super(key: key);

  final double borderRadius;
  final int? maxLength;
  final TextEditingController? controller;
  final onTap;
  final String? hint;
  final bool? enabled;
  final bool? obscure;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? Function(String? v)? validators;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefix;
  final Widget? suffixIcon;
  final String? errorText;
  final TextStyle? style;
  final TextInputAction? inputAction;
  final Function()? onEditingComplete;
  final bool? isDense;
  final InputBorder? border;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final Color? fillColor;
  final EdgeInsets? padding;
  final bool hideErrorText;
  final bool hideCounter;
  final bool readOnly;
  final int? minLines;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      key: key,
      minLines: minLines,
      focusNode: focusNode,
      enabled: enabled,
      textAlign: textAlign ?? TextAlign.left,
      maxLength: maxLength,
      keyboardType: textInputType,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      textInputAction: inputAction,
      initialValue: controller != null ? null : initialValue,
      controller: controller,
      onEditingComplete: onEditingComplete,
      validator: validators,
      maxLines: maxLines,
      onChanged: onChanged == null ? (_) {} : (value) => onChanged!(value.trim()),
      style: style ?? ThemeText.poppinsRegular.copyWith(fontSize: 14),
      inputFormatters: inputFormatter,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        counterText: hideCounter ? '' : null,
        isDense: isDense,
        hintText: hint,
        hintStyle: style?.copyWith(color: ThemeColor.hint) ?? ThemeText.poppinsRegular.copyWith(fontSize: 16, color: ThemeColor.hint),
        fillColor: fillColor,
        filled: fillColor != null,
        contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: border,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColor.pink), borderRadius: BorderRadius.circular(borderRadius)
        ),
        prefix: prefix,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: suffixIcon,
        ),
        counterStyle: style?.copyWith(color: ThemeColor.hint, fontSize: 11),
        errorText: errorText,
        errorMaxLines: 2,
        suffixIconConstraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
        errorStyle: ThemeText.poppinsRegular.copyWith(
          height: hideErrorText ? 0.7 : null,
          fontSize: 16,
          color: ThemeColor.error,
        ),
      ),
    );
  }
}

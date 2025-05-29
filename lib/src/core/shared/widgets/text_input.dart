import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    required this.title,
    required this.controller,
    super.key,
    this.trailing,
    this.leading,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.textStyle,
    this.autofocus,
    this.validator,
    this.obfuscate,
    this.enabled,
    this.maxLines,
  });

  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final TextEditingController controller;
  final bool? enabled;
  final Widget? leading;
  final bool? obfuscate;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextStyle? textStyle;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: textInputType,
        onTap: onTap,
        obscureText: obfuscate ?? false,
        autofocus: autofocus ?? false,
        onTapOutside: onTapOutside,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        enabled: enabled,
        maxLines: maxLines ?? 1,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: title,
          label: Text(title),
          //contentPadding: const EdgeInsets.symmetric(horizontal: 6),
          prefix: leading,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffix: trailing,
          fillColor: Theme.of(context).canvasColor,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        controller: controller,
      ),
    );
  }
}

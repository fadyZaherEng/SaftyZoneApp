import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWithSuffixIconWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelTitle;
  final String? errorMessage;
  final VoidCallback onTap;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget suffixIcon;
  final bool isReadOnly;
  final Function(String)? onSubmitted;

  const CustomTextFieldWithSuffixIconWidget({
    super.key,
    required this.controller,
    required this.labelTitle,
    required this.onTap,
    required this.suffixIcon,
    this.errorMessage,
    this.textInputType = TextInputType.text,
    this.inputFormatters,
    this.isReadOnly = false,
    this.onSubmitted,
  });

  @override
  State<CustomTextFieldWithSuffixIconWidget> createState() =>
      _CustomTextFieldWithSuffixIconWidgetState();
}

class _CustomTextFieldWithSuffixIconWidgetState
    extends State<CustomTextFieldWithSuffixIconWidget> {
  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      readOnly: widget.isReadOnly,
      focusNode: _focus,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: Constants.fontWeightRegular,
          color: ColorSchemes.black,
          letterSpacing: -0.13),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.redError),
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          errorText: widget.errorMessage,
          labelText: widget.labelTitle,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          labelStyle: _labelStyle(context, _textFieldHasFocus),
          errorMaxLines: 2,
          suffixIcon: widget.suffixIcon),
    );
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.controller.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.errorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.errorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    }
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }
}

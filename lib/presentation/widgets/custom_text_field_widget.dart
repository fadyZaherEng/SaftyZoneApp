import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
 import 'package:hatif_mobile/core/utils/constants.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelTitle;
  final bool isLabelTitle;
  final String? errorMessage;
  final double? height;
  final Function(String) onChange;
  final Function(String)? onSubmitted;
  final TextInputType textInputType;
  final TextAlignVertical? textAlignVertical;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final Color textColor;
  final double textHeight;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelTitle,
    required this.onChange,
    this.errorMessage,
    this.height = 1,
    this.textInputType = TextInputType.text,
    this.textAlignVertical,
    this.inputFormatters,
    this.isReadOnly = false,
    this.isLabelTitle = false,
    this.textColor = ColorSchemes.black,
    this.onSubmitted,
    this.textHeight = 54,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (!widget.isLabelTitle)
          Text(
            widget.labelTitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: Constants.fontWeightRegular,
                  color: ColorSchemes.gray,
                  fontSize: 13,
                ),
          ),
        if (!widget.isLabelTitle) const SizedBox(height: 12),
        widget.errorMessage == null
            ? SizedBox(
                height: widget.textHeight,
                child: _buildTextField(context),
              )
            : _buildTextField(context),
      ],
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

  Widget _buildTextField(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
       },
      readOnly: widget.isReadOnly,
      focusNode: _focus,
      textAlignVertical: widget.textAlignVertical,
      keyboardType: widget.textInputType,
      textInputAction: TextInputAction.done,
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      onChanged: widget.onChange,
      inputFormatters: widget.inputFormatters,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: Constants.fontWeightRegular,
            height: widget.height,
            color: widget.textColor,
            letterSpacing: -0.13,
          ),
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
        labelText: widget.isLabelTitle ? widget.labelTitle : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        labelStyle: _labelStyle(context, _textFieldHasFocus),
        errorMaxLines: 2,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/constants.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChange;
  final Function() onClear;
  final String searchText;
  final bool isShowSuffixIcon;

  const SearchTextFieldWidget({
    super.key,
    required this.controller,
    required this.onChange,
    required this.searchText,
    required this.onClear,
    this.isShowSuffixIcon = false,
  });

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  bool _showHideClearIcon = false;
  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    if (mounted) {
      _focus.addListener(() {
        setState(() {
          _textFieldHasFocus = _focus.hasFocus;
        });
      });
      widget.controller.addListener(() {
        if (widget.controller.text.isEmpty) {
          _showHideClearIcon = false;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focus,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: _onChange,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: ColorSchemes.black, letterSpacing: -0.13),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorSchemes.secondary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: widget.searchText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: ColorSchemes.primary, letterSpacing: -0.13),
        prefixIconConstraints:
            const BoxConstraints(maxHeight: 40, maxWidth: 40),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SvgPicture.asset(
            ImagePaths.search,
            color: ColorSchemes.primary,
            width: 24,
            height: 24,
          ),
        ),
        suffixIcon: InkWell(
          onTap: _onClear,
          child: _showHideClearIcon
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, bottom: 5, right: 10, top: 5),
                  child: SvgPicture.asset(
                    fit: BoxFit.scaleDown,
                    ImagePaths.close,
                    color: ColorSchemes.primary,
                    width: 24,
                    height: 24,
                  ),
                )
              : const SizedBox(),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        labelStyle: _labelStyle(context, _textFieldHasFocus),
      ),
    );
  }

  void _onClear() {
    setState(() {
      _showHideClearIcon = false;
      widget.controller.clear();
    });
    widget.onClear();
  }

  void _onChange(String value) {
    setState(() {
      if (value.trim().isNotEmpty) {
        _showHideClearIcon = true;
      } else {
        _showHideClearIcon = false;
      }
    });
    widget.onChange(value);
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.controller.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: ColorSchemes.gray,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: ColorSchemes.gray,
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

import 'package:flutter/material.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/generated/l10n.dart';

class HeaderWidget extends StatelessWidget {
  final List<dynamic> predictions;
  final TextEditingController searchController;
  final void Function(String query) getPredictions;
  final void Function() clearSearch;

  const HeaderWidget({
    super.key,
    required this.predictions,
    required this.searchController,
    required this.getPredictions,
    required this.clearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorSchemes.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (value) => getPredictions(value),
            decoration: InputDecoration(
              hintText: S.of(context).searchAboutYourLocation,
              hintStyle: const TextStyle(
                fontSize: 12,
                color: ColorSchemes.gray,
              ),
              prefixIcon: const Icon(
                Icons.my_location,
                color: ColorSchemes.black,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: ColorSchemes.black,
                ),
                onPressed: clearSearch,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

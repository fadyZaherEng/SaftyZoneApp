import 'package:flutter/material.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/presentation/widgets/no_internet_widget.dart';

Future showNoInternetDialogWidget({
  required BuildContext context,
  required Function() onTapTryAgain,
}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: WillPopScope(
        onWillPop: () async => Future.value(false),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorSchemes.searchBackground,
                  offset: Offset(0, 0),
                  blurRadius: 15,
                ),
              ],
              color: ColorSchemes.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: NoInternetWidget(onTapTryAgain: onTapTryAgain),
          ),
        ),
      ),
    ),
  );
}

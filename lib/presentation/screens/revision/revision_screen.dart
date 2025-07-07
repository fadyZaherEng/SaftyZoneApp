import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatif_mobile/config/routes/routes_manager.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/widgets/custom_button_widget.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorSchemes.white,
            ),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.languageSelection,
              (route) => false,
            ),
          ),
          backgroundColor: ColorSchemes.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset(
                ImagePaths.revision,
                width: 190.w,
                height: 190.h,
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).yourInformationHasBeenSentForReview,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: ColorSchemes.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                S
                    .of(context)
                    .youWillReceiveAnEmailAfterAcceptingOrDecliningYourDetailsInCaseOfAnyErrors,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorSchemes.black,
                ),
              ),
              Spacer(),
              CustomButtonWidget(
                backgroundColor: ColorSchemes.red,
                textColor: ColorSchemes.white,
                text: S.of(context).login,
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.languageSelection,
                    (route) => false,
                  );
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

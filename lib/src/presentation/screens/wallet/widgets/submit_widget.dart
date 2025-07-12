import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';

class SubmitInvoiceSection extends StatefulWidget {
  const SubmitInvoiceSection({super.key});

  @override
  State<SubmitInvoiceSection> createState() => _SubmitInvoiceSectionState();
}

class _SubmitInvoiceSectionState extends State<SubmitInvoiceSection> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  bool _accepted = false;

  @override
  void initState() {
    super.initState();
    _amountController.text = '100';
    _taxController.text = '15';
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        SizedBox(
          height: 100.h,
          child: Row(
            children: [
              _buildSummaryCard(
                s.currentBalance,
                '200 ر.س',
                ImagePaths.price,
                ColorSchemes.primary,
              ),
              const SizedBox(width: 8),
              _buildSummaryCard(
                s.otherTransactionValue,
                '600 ر.س',
                "assets/images/price-down.svg",
                ColorSchemes.secondary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    s.submitInvoice,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    ImagePaths.arrowDown,
                    width: 24,
                    height: 24,
                    color: ColorSchemes.primary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField(s.invoiceAmount, _amountController),
              const SizedBox(height: 12),
              _buildTextField(s.taxLabel, _taxController),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    s.uploadInvoice,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 140.w,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorSchemes.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.of(context).upload,
                              style: TextStyle(
                                color: ColorSchemes.primary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              ImagePaths.addProgress,
                              width: 18,
                              height: 18,
                              color: ColorSchemes.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: _accepted,
                    onChanged: (val) {
                      setState(() => _accepted = val!);
                    },
                  ),
                  Expanded(
                    child: Text(
                      s.invoiceNote,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              CustomButtonWidget(
                text: s.submitInvoice,
                onTap: () => debugPrint("ارسال"),
                backgroundColor: ColorSchemes.primary,
                textColor: ColorSchemes.white,
              ),
             ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, String icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    color: color,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  )
                ],
              ),
              const Spacer(),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: ColorSchemes.gray,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: ColorSchemes.black,
          ),
        ),
        const SizedBox(width: 16),
        const Spacer(),
        SizedBox(
          width: 100,
          height: 34,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA50000)),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA50000)),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              filled: true,
              fillColor: ColorSchemes.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

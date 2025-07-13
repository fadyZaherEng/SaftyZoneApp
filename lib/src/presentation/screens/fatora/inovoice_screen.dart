import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                ImagePaths.inovoice,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            s.platformDesc,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            s.platformName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/logo.png",
                        width: 48,
                        height: 48,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          s.requestType,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${s.date}: 2025-05-12",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${s.requestNumber}: #2458926",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              s.clientInfo,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                            ),
                            Text(
                              "${s.clientName}: محمد قاسم",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                            ),
                            Text(
                              "${s.serviceLocation}: الرياض - طريق الدفاع المدني - العليا",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              s.providerInfo,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                            ),
                            Text(
                              "${s.providerName}: محمد علي",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                            ),
                            Text(
                              "${s.providerRating}: 4.5",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    s.extinguishersDetails,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildTable(s),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSignatureBox(
                          s.firstParty,
                          "المسؤول عن الاتحاد",
                          context: context,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSignatureBox(
                          s.secondParty,
                          s.providerName,
                          context: context,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${s.note}:",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    s.noteTexts,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable(s) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          _cell(s.type, bold: true),
          _cell(s.toRepair, bold: true),
          _cell(s.received, bold: true),
          _cell(s.price, bold: true),
        ]),
        ...[
          ["طفاية بودرة 6 كجم", "4", "4", "120 ريال"],
          ["طفاية بودرة 12 كجم", "4", "4", "120 ريال"],
          ["طفاية CO2", "4", "4", "120 ريال"],
        ].map((row) => TableRow(children: row.map(_cell).toList())),
      ],
    );
  }

  Widget _cell(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildSignatureBox(String party, String name,
      {required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(party, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text("${S.of(context).name}: $name"),
        const SizedBox(height: 16),
        Text("${S.of(context).signature}: __________"),
      ],
    );
  }
}

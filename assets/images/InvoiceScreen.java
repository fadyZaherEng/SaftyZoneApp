import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(s.platformName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.platformDesc, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Text("${s.requestType}", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Text("${s.date}: 2025-05-12"),
            Text("${s.requestNumber}: #2458926"),
            const Divider(),

            Text(s.clientInfo, style: Theme.of(context).textTheme.titleSmall),
            Text("${s.clientName}: محمد قاسم"),
            Text("${s.serviceLocation}: الرياض - طريق الدفاع المدني - العليا"),
            const Divider(),

            Text(s.providerInfo, style: Theme.of(context).textTheme.titleSmall),
            Text("${s.providerName}: محمد علي"),
            Text("${s.providerRating}: 4.5"),
            const Divider(),

            Text(s.extinguishersDetails, style: Theme.of(context).textTheme.titleMedium),
            _buildTable(s),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildSignatureBox(s.firstParty, "المسؤول عن الاتحاد")),
                const SizedBox(width: 12),
                Expanded(child: _buildSignatureBox(s.secondParty, s.providerName)),
              ],
            ),

            const SizedBox(height: 16),
            Text("${s.note}:", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(s.noteText),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(AppLocalizations s) {
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
        style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  Widget _buildSignatureBox(String party, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(party, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text("${AppLocalizations.of(null)?.name ?? "الاسم"}: $name"),
        const SizedBox(height: 16),
        Text("${AppLocalizations.of(null)?.signature ?? "التوقيع"}: __________"),
      ],
    );
  }
}

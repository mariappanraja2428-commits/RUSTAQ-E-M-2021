import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/records_provider.dart';
import 'package:excel/excel.dart';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecordsProvider>(context);
    final areas = provider.records.map((e) => e.area).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              // Excel export
              final excel = Excel.createExcel();
              for (var area in areas) {
                final sheet = excel[area];
                sheet.appendRow(['Line','Size','Material','OHL/Cable/MFP','Meter','Feeder','TX No','Place','Location','Before Photo','After Photo']);
                for (var r in provider.getRecordsByArea(area)) {
                  sheet.appendRow([
                    r.line,r.size,r.material,r.ohlCableMfp,r.meter,r.feeder,r.txNo,r.place,r.location,r.beforePhotoPath,r.afterPhotoPath
                  ]);
                }
              }
              final fileBytes = excel.encode();
              final blob = html.Blob([fileBytes]);
              final url = html.Url.createObjectUrlFromBlob(blob);
              final anchor = html.AnchorElement(href: url)
                ..setAttribute('download', 'records.xlsx')
                ..click();
            },
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = pw.Document();
              for (var area in areas) {
                pdf.addPage(
                  pw.MultiPage(
                    build: (context) {
                      final records = provider.getRecordsByArea(area);
                      return [
                        pw.Header(level: 0, text: area),
                        pw.Table.fromTextArray(
                          context: context,
                          data: [
                            ['Line','Size','Material','OHL/Cable/MFP','Meter','Feeder','TX No','Place','Location','Before Photo','After Photo'],
                            ...records.map((r) => [r.line,r.size,r.material,r.ohlCableMfp,r.meter,r.feeder,r.txNo,r.place,r.location,r.beforePhotoPath,r.afterPhotoPath])
                          ],
                        ),
                      ];
                    },
                  ),
                );
              }
              await Printing.layoutPdf(onLayout: (format) async => pdf.save());
            },
          ),
        ],
      ),
      body: ListView(
        children: areas.map((area) {
          final records = provider.getRecordsByArea(area);
          return ExpansionTile(
            title: Text(area),
            children: records.map((r) {
              return ListTile(
                title: Text('${r.line} - ${r.size}'),
                subtitle: Text('Material: ${r.material} | Feeder: ${r.feeder}'),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

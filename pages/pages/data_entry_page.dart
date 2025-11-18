import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/record.dart';
import '../providers/records_provider.dart';
import '../widgets/photo_upload.dart';

class DataEntryPage extends StatefulWidget {
  final String area;
  const DataEntryPage({super.key, required this.area});

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  String? line, size, material, ohlCableMfp;
  String meter = '', feeder = '', txNo = '', place = '', location = '';
  String? beforePhoto, afterPhoto;

  final lineOptions = ['OHL', 'CABLE', 'MFP CLEARANCE'];
  final sizeOptions = ['LT', '11KVA', '33KVA'];
  final materialOptions = ['CONDUCTOR', 'CABLE', 'MFP', 'FOUNDATION'];
  final ohlOptions = [
    '35mm','70mm','120mm','200mm','DOG CONDUCTOR','WOLF CONDUCTOR','PANTHER CONDUCTOR'
  ];
  final mfpOptions = [
    'FOUNDATION BROKEN','MFP IS GROUND DOWN','MFP DAMAGED','MFP AIR FLOWER'
  ];
  final cableOptionsLT = ['4C X 25mm','4C X 35mm','4C X 50mm','4C X 70mm','4C X 95mm','4C X 120mm','4C X 185mm','4C X 240mm','OTHER'];
  final cableOptions11 = ['3C X 50mm','3C X 70mm','3C X 95mm','3C X 120mm','3C X 185mm','3C X 240mm','OTHER'];
  final cableOptions33 = ['3C X 50mm','3C X 70mm','3C X 95mm','3C X 120mm','3C X 185mm','3C X 240mm','OTHER'];

  List<String> getCableOptions() {
    if (size == 'LT') return cableOptionsLT;
    if (size == '11KVA') return cableOptions11;
    if (size == '33KVA') return cableOptions33;
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecordsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('${widget.area} Data Entry')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Line'),
              value: line,
              items: lineOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => line = v),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Size'),
              value: size,
              items: sizeOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => size = v),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Material'),
              value: material,
              items: materialOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => material = v),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'OHL / Cable / MFP'),
              value: ohlCableMfp,
              items: line == 'OHL'
                  ? ohlOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList()
                  : line == 'CABLE'
                      ? getCableOptions().map((e) => DropdownMenuItem(value: e, child: Text(e))).toList()
                      : line == 'MFP CLEARANCE'
                          ? mfpOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList()
                          : [],
              onChanged: (v) => setState(() => ohlCableMfp = v),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Meter'),
              onChanged: (v) => meter = v,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Feeder Name'),
              onChanged: (v) => feeder = v,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'TX No'),
              onChanged: (v) => txNo = v,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Place'),
              onChanged: (v) => place = v,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Location'),
              onChanged: (v) => location = v,
            ),
            const SizedBox(height: 10),
            PhotoUpload(label: 'Before Photo', onSelected: (p) => beforePhoto = p),
            const SizedBox(height: 10),
            PhotoUpload(label: 'After Photo', onSelected: (p) => afterPhoto = p),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (line != null && size != null && material != null && ohlCableMfp != null) {
                    provider.addRecord(Record(
                      area: widget.area,
                      line: line!,
                      size: size!,
                      material: material!,
                      ohlCableMfp: ohlCableMfp!,
                      meter: meter,
                      feeder: feeder,
                      txNo: txNo,
                      place: place,
                      location: location,
                      beforePhotoPath: beforePhoto ?? '',
                      afterPhotoPath: afterPhoto ?? '',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Record Saved')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill required fields')));
                  }
                },
                child: const Text('Save Record'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

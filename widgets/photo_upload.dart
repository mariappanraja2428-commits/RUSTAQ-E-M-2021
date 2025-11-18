import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PhotoUpload extends StatefulWidget {
  final String label;
  final Function(String) onSelected;

  const PhotoUpload({super.key, required this.label, required this.onSelected});

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Row(
          children: [
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.image);
                  if (result != null) {
                    setState(() {
                      filePath = result.files.single.path;
                    });
                    widget.onSelected(filePath!);
                  }
                },
                child: const Text("Upload")),
            const SizedBox(width: 10),
            if (filePath != null) Text("Selected: ${filePath!.split('/').last}"),
          ],
        ),
      ],
    );
  }
}

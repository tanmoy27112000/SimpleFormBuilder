import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void fileUpload({
  required BuildContext context,
  required Function(dynamic) files,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Pick from Gallery'),
            onTap: () async {
              Navigator.of(context).pop();
              FilePickerResult? result =
                  await FilePicker.platform.pickFiles(allowMultiple: true);

              if (result != null) {
                List<File> selectedFiles =
                    result.paths.map((path) => File(path ?? '')).toList();
                files.call(selectedFiles);
              }
            },
          ),
          ListTile(
            title: const Text('Pick from Camera'),
            onTap: () async {
              Navigator.of(context).pop();
              // Pick an icon
              final icon =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (icon != null) {
                List<File> selectedFiles = [File(icon.path)];
                files.call(selectedFiles);
              }
            },
          )
        ],
      );
    },
  );
}

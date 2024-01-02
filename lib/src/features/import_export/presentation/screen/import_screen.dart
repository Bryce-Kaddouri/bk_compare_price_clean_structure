import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import'),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['csv'],
                  );

                  if (result != null) {
                    /*File file = File(result.files.single.path!);*/
                    PlatformFile file = result.files.first;

                    print(file.name);
                    print(file.bytes);
                    print(file.size);
                    print(file.extension);
                    if (!kIsWeb) {
                      print(file.path);
                    }

                    // get File from Uint8List
                    File file1 = File.fromRawPath(file.bytes!);
                    final imput = file1.openRead();
/*
                    file1.readAsBytesSync();

*/
                    /*final res = const CsvToListConverter().convert('",b",3.1,42\r\n"n\n"');
                    print(res);
                    assert(res.toString() ==
                        [
                          [',b', 3.1, 42],
                          ['n\n']
                        ].toString());*/
                    final fields = await imput.transform(utf8.decoder);

                    print(fields);

                    print(imput);
                  } else {
                    // User canceled the picker
                  }
                },
                child: Text('import csv file'))
          ],
        ),
      ),
    );
  }
}

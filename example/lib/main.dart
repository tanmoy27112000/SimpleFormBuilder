import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_form_builder/formbuilder.dart';
import 'package:simple_form_builder/global/checklistModel.dart';
import 'package:simple_form_builder/global/constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilder Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                initialData: sampleData,
                index: 0,
                onUpload: fileUpload(),
                showIndex: false,
                submitButtonWidth: 0.5,
                submitButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                showIcon: false,
                onSubmit: (ChecklistModel val) {
                  if (val == null) {
                    print("no data");
                  } else {
                    var json = jsonEncode(val.toJson());
                    print(json);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  fileUpload() {
    return "";
  }
}

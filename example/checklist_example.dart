import 'package:flutter/material.dart';
import 'package:formbuilder/formbuilder.dart';
import 'package:formbuilder/global/constant.dart';
import 'package:formbuilder/src/models/checklistModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static ChecklistModel checklistModel = ChecklistModel.fromJson(sampleData);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilder Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Column(
          children: [
            FormBuilder(initialData: checklistModel),
          ],
        ),
      ),
    );
  }
}

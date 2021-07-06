import 'package:flutter/material.dart';
import 'package:simple_form_builder/formbuilder.dart';
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
                submitButtonWidth: 0.8,
                // submitButtonDecoration: BoxDecoration(color: Color),
                showIcon: false,
                onSubmit: (val) {
                  print(val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

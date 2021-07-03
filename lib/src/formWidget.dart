import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:simple_form_builder/src/controllers/checklistController.dart';
import 'package:simple_form_builder/src/widgets/checkboxWidget.dart';
import 'package:simple_form_builder/src/widgets/dateTimeWidget.dart';
import 'package:simple_form_builder/src/widgets/dropdownWidget.dart';
import 'package:simple_form_builder/src/widgets/radioWidget.dart';
import 'package:simple_form_builder/src/widgets/textWidget.dart';

import 'models/checklistModel.dart';

class FormBuilder extends StatefulWidget {
  final Map<String, dynamic> initialData;

  FormBuilder({
    required this.initialData,
  });

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  ChecklistController? checklistController;
  ChecklistModel? checklistModel;
  @override
  void initState() {
    checklistController =
        Provider.of<ChecklistController>(context, listen: false);
    checklistModel = ChecklistModel.fromJson(widget.initialData);
    checklistController!.setCurrentQuestion(checklistModel!.data![0].questions);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...checklistController!.currentQuestions!
                  .map((e) => questionWidget(e))
                  .toList(),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  print(getCompleteData());
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCompleteData() {
    return checklistController!.checklistModel!.toJson();
  }

  Widget questionWidget(Questions e) {
    switch (e.type) {
      case "multiple":
        return radioWidget(e, context);

      case "dropdown":
        return dropdownWidget(context, e);

      case "checkbox":
        return checkboxWidget(e, context);

      case "date":
        return dateTimeWidget(context, e);

      case "text":
        return textWidget(context, e);

      default:
        return SizedBox();
    }
  }
}

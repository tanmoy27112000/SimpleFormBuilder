import 'package:flutter/material.dart';
import 'package:formbuilder/src/controllers/checklistController.dart';
import 'package:formbuilder/src/widgets/checkboxWidget.dart';
import 'package:formbuilder/src/widgets/dateTimeWidget.dart';
import 'package:formbuilder/src/widgets/dropdownWidget.dart';
import 'package:formbuilder/src/widgets/radioWidget.dart';
import 'package:formbuilder/src/widgets/textWidget.dart';
import 'package:provider/provider.dart';

import 'models/checklistModel.dart';

class FormBuilder extends StatefulWidget {
  final ChecklistModel initialData;

  FormBuilder({
    required this.initialData,
  });

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  ChecklistController? checklistController;
  @override
  void initState() {
    checklistController =
        Provider.of<ChecklistController>(context, listen: false);
    checklistController!
        .setCurrentQuestion(widget.initialData.data![0].questions);
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

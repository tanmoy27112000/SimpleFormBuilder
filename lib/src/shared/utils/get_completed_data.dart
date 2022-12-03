import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/shared/checklistModel.dart';

ChecklistModel? getCompleteData({
  required BuildContext context,
  required int index,
  ChecklistModel? checklistModel,
}) {
  int f = 0;
  List<Questions>? questions = checklistModel!.data![index].questions;
  for (Questions item in questions!) {
    if (item.answer == null && item.isMandatory == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${item.title} is mandatory"),
        ),
      );
      f = 1;
      break;
    }
  }
  return f == 0 ? checklistModel : null;
}

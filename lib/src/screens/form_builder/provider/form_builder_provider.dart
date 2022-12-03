import 'package:flutter/cupertino.dart';
import 'package:simple_form_builder/src/shared/checklistModel.dart';

class FormBuilderProvider extends ChangeNotifier {
  Map<String, dynamic> initial;
  ChecklistModel? checklistModel;

  FormBuilderProvider({required this.initial}) {
    checklistModel = ChecklistModel.fromJson(initial);
  }

  void setAnswers(Questions questions, Object? value, int index) {
    final idx = checklistModel?.data?[index].questions?.indexOf(questions);
    final question = checklistModel?.data?[index].questions?[idx!];
    question?.answer = value;

    notifyListeners();
  }

  void setRemarks(Questions questions, String? value, int index) {
    final idx = checklistModel?.data?[index].questions?.indexOf(questions);
    final question = checklistModel?.data?[index].questions?[idx!];
    question?.remarkData = value;

    notifyListeners();
  }
}

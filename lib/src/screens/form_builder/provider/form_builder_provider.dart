import 'package:flutter/cupertino.dart';
import 'package:simple_form_builder/src/shared/checklistModel.dart';

class FormBuilderProvider extends ChangeNotifier {
  Map<String, dynamic> initial;
  ChecklistModel? checklistModel;

  FormBuilderProvider({required this.initial}) {
    checklistModel = ChecklistModel.fromJson(initial);
  }

  void setAnswer(
      {required Questions questions, Object? value, required int index}) {
    final idx = checklistModel?.data?[index].questions?.indexOf(questions);
    final question = checklistModel?.data?[index].questions?[idx!];
    question?.answer = value;

    notifyListeners();
  }

  void setRemark(Questions questions, String? value, int index) {
    final idx = checklistModel?.data?[index].questions?.indexOf(questions);
    final question = checklistModel?.data?[index].questions?[idx!];
    question?.remarkData = value;

    notifyListeners();
  }

  void setCheckboxAnswers({
    required Questions questions,
    bool? input,
    required String checked,
    required int index,
  }) {
    final idx = checklistModel?.data?[index].questions?.indexOf(questions);
    final question = checklistModel?.data?[index].questions?[idx!];
    question?.answer[questions.fields!.indexOf(checked)] = input;

    notifyListeners();
  }
}

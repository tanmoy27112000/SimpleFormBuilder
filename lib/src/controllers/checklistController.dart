import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/models/checklistModel.dart';

class ChecklistController extends ChangeNotifier {
  var authResponseModel;
  BuildContext? context;
  int activeTabIndex = 0;
  bool isLoading = false;
  ChecklistModel? checklistModel;

  List<Questions>? currentQuestions;

  setCurrentQuestion(List<Questions>? question) {
    currentQuestions = question;
    notifyListeners();
  }

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  //* saving context
  setContext(BuildContext context, Function setstate) async {
    this.context = context;
    checklistModel ?? await getAllChecklist();
    setstate();
  }

  //*to change recent and history
  changeTab(index) {
    activeTabIndex = index;
    notifyListeners();
  }

  getAllChecklist() async {
    startLoading();
    // var path = "checklist";
    // var result = await AppConfig.of(context).baseApi.getRequest(path, context);
    // if (result.runtimeType == CommonResponseModel) {
    //   stopLoading();
    // } else {
    //   checklistModel = ChecklistModel.fromJson(result);
    //   if (checklistModel.status == 1) {
    //     checklistList = checklistModel.data;
    //     searchedList.clear();
    //     searchedList.addAll(checklistList);
    //     print(checklistList);
    //   } else {
    //     checklistList.clear();
    //   }
    stopLoading();
  }

  resetQuestions() {
    currentQuestions!.clear();
    notifyListeners();
  }

  //*to set all other fields
  void setAnswer(value, int index) {
    currentQuestions![index].answer = value;
    notifyListeners();
  }

  //* to set checkbox answer
  void setCheckBoxAnswer(value, int index, int position) {
    currentQuestions![index].answer[position] = value;
    notifyListeners();
  }
}

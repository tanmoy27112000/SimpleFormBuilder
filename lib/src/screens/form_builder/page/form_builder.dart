// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_checkbox.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_dropdown.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_multiple.dart';

import 'package:simple_form_builder/src/shared/constant.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/custom_dropdown.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/description_widget.dart';

import '../../../shared/checklistModel.dart';

class FormBuilder extends StatefulWidget {
  final Map<String, dynamic> initialData;

  final InputDecoration? textfieldDecoration;
  final String? title;
  final TextStyle? titleStyle;
  final CrossAxisAlignment widgetCrossAxisAlignment;
  final String? description;
  final TextStyle? descriptionStyle;
  final bool showIndex;
  final String? multipleimage,
      dropdownImage,
      dateImage,
      textImage,
      checkboxImage,
      remarkImage,
      submitButtonText;
  final int index;
  final double? textFieldWidth;
  final bool showIcon;
  final Function onSubmit;
  final double? submitButtonWidth;
  final BoxDecoration? submitButtonDecoration;
  final TextStyle? submitTextDecoration;
  final TextStyle? titleTextDecoration;
  final TextStyle? descriptionTextDecoration;

  const FormBuilder({
    required this.initialData,
    required this.index,
    this.textfieldDecoration, //adds inputdecoration to textfields
    this.textFieldWidth, //to change the width of textField
    this.multipleimage, //adds  icon for case 'multiple'
    this.dropdownImage, //adds  icon for case 'dropdown'
    this.checkboxImage, //adds  icon for case 'checkbox'
    this.dateImage, //adds  icon for case 'date'
    this.textImage, //adds  icon for case 'text'
    this.remarkImage, //adds icon for remarks
    this.submitButtonText,
    this.showIcon = false, //to enable or disable question icon
    required this.onSubmit,
    this.showIndex = true,
    this.submitButtonDecoration,
    this.submitButtonWidth = 0.5,
    this.submitTextDecoration,
    this.title,
    this.description,
    this.descriptionStyle,
    this.titleStyle,
    this.widgetCrossAxisAlignment = CrossAxisAlignment.start,
    this.titleTextDecoration,
    this.descriptionTextDecoration,
  });

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  ChecklistModel? checklistModel;

  @override
  void initState() {
    checklistModel = ChecklistModel.fromJson(widget.initialData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: widget.widgetCrossAxisAlignment,
          children: [
            widget.title != null
                ? Text(
                    widget.title!,
                    style: widget.titleStyle ?? TextStyle(),
                  )
                : SizedBox.shrink(),
            widget.description != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.description!,
                      style: widget.descriptionStyle ?? TextStyle(),
                    ),
                  )
                : SizedBox.shrink(),
            ...checklistModel!.data![widget.index].questions!
                .map((e) => questionWidget(e, widget.showIcon))
                .toList(),
            SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  widget.onSubmit(getCompleteData(widget.index));
                },
                child: Container(
                  height: 50,
                  width: screenWidth(
                    context: context,
                    mulBy: widget.submitButtonWidth ?? 0.5,
                  ),
                  decoration: widget.submitButtonDecoration ??
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                  child: Center(
                    child: Text(
                      widget.submitButtonText ?? "Submit",
                      style: widget.submitTextDecoration ??
                          TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCompleteData(int index) {
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

  Widget questionWidget(
    Questions questions,
    bool remarks,
  ) {
    switch (questions.type) {
      case "multiple":
        return SimpleMultiple(
          questions: questions,
          showIcon: remarks,
          showIndex: widget.showIndex,
          index: widget.index,
          descriptionTextDecoration: widget.descriptionTextDecoration,
          multipleimage: widget.multipleimage,
          titleTextDecoration: widget.titleTextDecoration,
          remarkImage: widget.remarkImage,
        );
      case "dropdown":
        return SimpleDropdown(
          questions: questions,
          showIcon: remarks,
          showIndex: widget.showIndex,
          remarkImage: widget.remarkImage,
          index: widget.index,
          checklistModel: checklistModel,
          dropdownImage: widget.dropdownImage,
          descriptionTextDecoration: widget.descriptionTextDecoration,
        );
      case "checkbox":
        return SimpleCheckbox(
          questions: questions,
          checklistModel: checklistModel,
          showIndex: widget.showIndex,
          checkboxImage: widget.checkboxImage,
          remarkImage: widget.remarkImage,
          index: widget.index,
          showIcon: remarks,
          descriptionTextDecoration: widget.descriptionTextDecoration,
        );
      case "datetime":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.showIcon
                      ? iconContainer(widget.dateImage)
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                        "${widget.showIndex ? "${checklistModel!.data![widget.index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}"),
                  ),
                  DescriptionWidget(
                    questions: questions,
                    textStyle: widget.descriptionTextDecoration,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(),
                    child: Builder(
                      builder: (context) => CustomDropdown(
                        onChanged: (val) {
                          print(val);
                        },
                        onTap: () async {
                          DateTime tempDate = await selectDate(context);

                          if (questions.answer == null) {
                            setState(() {
                              questions.answer = tempDate;
                            });
                          } else {
                            setState(() {
                              questions.answer = DateTime(
                                tempDate.year,
                                tempDate.month,
                                tempDate.day,
                                questions.answer.hour,
                                questions.answer.minute,
                              );
                            });
                          }
                        },
                        title: questions.answer == null
                            ? "DD-MM-YYYY"
                            : dateFormater.format(questions.answer),
                        // date != null ? dateFormater.format(date) : "DD-MM-YYYY",
                        showImage: false,
                        isRequired: false,
                        width: screenWidth(context: context, mulBy: 0.4),
                      ),
                    ),
                  ),
                  CustomDropdown(
                    onChanged: (val) {},
                    onTap: () async {
                      TimeOfDay tempTime = await selectTime(context);

                      if (questions.answer == null) {
                        setState(() {
                          questions.answer = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      } else {
                        setState(() {
                          questions.answer = DateTime(
                            questions.answer.year,
                            questions.answer.month,
                            questions.answer.day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      }

                      // reminderController.updateIschanged(true);
                    },
                    title: questions.answer != null
                        ? formatTimeOfDay(
                            TimeOfDay.fromDateTime(questions.answer))
                        : "Hr:Mins",
                    showImage: false,
                    isRequired: false,
                    width: screenWidth(context: context, mulBy: 0.3),
                  ),
                ],
              ),
            ),
            remarkWidget(questions, remarks, widget.remarkImage),
          ],
        );
      case "time":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.showIcon
                      ? iconContainer(widget.dateImage)
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                        "${widget.showIndex ? "${checklistModel!.data![widget.index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}"),
                  ),
                  DescriptionWidget(
                    questions: questions,
                    textStyle: widget.descriptionTextDecoration,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  CustomDropdown(
                    onChanged: (val) {},
                    onTap: () async {
                      TimeOfDay tempTime = await selectTime(context);

                      if (questions.answer == null) {
                        setState(() {
                          questions.answer = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      } else {
                        setState(() {
                          questions.answer = DateTime(
                            questions.answer.year,
                            questions.answer.month,
                            questions.answer.day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      }

                      // reminderController.updateIschanged(true);
                    },
                    title: questions.answer != null
                        ? formatTimeOfDay(
                            TimeOfDay.fromDateTime(questions.answer))
                        : "Hr:Mins",
                    showImage: false,
                    isRequired: false,
                    width: screenWidth(context: context, mulBy: 0.3),
                  ),
                ],
              ),
            ),
            remarkWidget(questions, remarks, widget.remarkImage),
          ],
        );

      case "date":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.showIcon
                      ? iconContainer(widget.dateImage)
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                        "${widget.showIndex ? "${checklistModel!.data![widget.index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}"),
                  ),
                  DescriptionWidget(
                    questions: questions,
                    textStyle: widget.descriptionTextDecoration,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(),
                    child: Builder(
                      builder: (context) => CustomDropdown(
                        onChanged: (val) {
                          print(val);
                        },
                        onTap: () async {
                          DateTime tempDate = await selectDate(context);

                          if (questions.answer == null) {
                            setState(() {
                              questions.answer = tempDate;
                            });
                          } else {
                            setState(() {
                              questions.answer = DateTime(
                                tempDate.year,
                                tempDate.month,
                                tempDate.day,
                                questions.answer.hour,
                                questions.answer.minute,
                              );
                            });
                          }
                        },
                        title: questions.answer == null
                            ? "DD-MM-YYYY"
                            : dateFormater.format(questions.answer),
                        // date != null ? dateFormater.format(date) : "DD-MM-YYYY",
                        showImage: false,
                        isRequired: false,
                        width: screenWidth(context: context, mulBy: 0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            remarkWidget(questions, remarks, widget.remarkImage),
          ],
        );

      case "file":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                        "${widget.showIndex ? "${checklistModel!.data![widget.index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}"),
                  ),
                ),
                DescriptionWidget(
                  questions: questions,
                  textStyle: widget.descriptionTextDecoration,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 70,
                          width: 100,
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.grey[500],
                            size: 70,
                          ),
                        ),
                        questions.answer != null
                            ? CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 15,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => fileUpload(
                        (files) => setState(() => questions.answer = files)),
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
            remarkWidget(questions, remarks, widget.remarkImage),
          ],
        );

      case "text":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.showIcon
                      ? iconContainer(widget.textImage)
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                        "${widget.showIndex ? "${checklistModel!.data![widget.index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}"),
                  ),
                  DescriptionWidget(
                    questions: questions,
                    textStyle: widget.descriptionTextDecoration,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: Container(
                width: screenWidth(
                    context: context,
                    mulBy: widget.textFieldWidth == null
                        ? 0.9
                        : widget.textFieldWidth),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      maxLines: questions.maxline,
                      onChanged: (value) {
                        // e.answer = value;
                        setState(() {
                          questions.answer = value;
                        });
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: widget.textfieldDecoration ??
                          InputDecoration.collapsed(
                            hintText: "Enter text here",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ),
            remarkWidget(questions, remarks, widget.remarkImage),
          ],
        );

      default:
        return SizedBox();
    }
  }

  Widget iconContainer(icon) {
    return icon == null
        ? Container()
        : Container(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              icon,
              height: 20,
            ),
          );
  }

  Widget remarkWidget(Questions e, showIcon, icon) {
    return e.remark
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: <Widget>[
                    showIcon == false
                        ? SizedBox(
                            width: 16,
                          )
                        : icon == null
                            ? Container(
                                padding: EdgeInsets.only(left: 16),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Image.asset(
                                  icon,
                                  height: 20,
                                ),
                              ),
                    Text("Enter remarks"),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          onChanged: (value) {
                            e.remarkData = value;
                            setState(() {});
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: "Enter your remarks",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : SizedBox.shrink();
  }

  void fileUpload(Function(dynamic) files) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(allowMultiple: true);

                  if (result != null) {
                    List<File> selectedFiles =
                        result.paths.map((path) => File(path ?? '')).toList();
                    files.call(selectedFiles);
                  }
                },
              ),
              ListTile(
                title: const Text('Pick from Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  // Pick an icon
                  final icon =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (icon != null) {
                    List<File> selectedFiles = [File(icon.path)];
                    files.call(selectedFiles);
                  }
                },
              )
            ],
          );
        });
  }
}

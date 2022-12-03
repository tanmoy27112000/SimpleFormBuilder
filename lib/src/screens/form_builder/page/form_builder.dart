import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_checkbox.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_date.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_datetime.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_dropdown.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_file.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_multiple.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_text.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_time.dart';

import 'package:simple_form_builder/src/shared/constant.dart';
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
        return SimpleDateTime(
          questions: questions,
          checklistModel: checklistModel,
          showIndex: widget.showIndex,
          dateImage: widget.dateImage,
          remarkImage: widget.remarkImage,
          index: widget.index,
          showIcon: remarks,
          descriptionTextDecoration: widget.descriptionTextDecoration,
        );
      case "time":
        return SimpleTime(
          questions: questions,
          checklistModel: checklistModel,
          showIndex: widget.showIndex,
          dateImage: widget.dateImage,
          remarkImage: widget.remarkImage,
          index: widget.index,
          showIcon: remarks,
          descriptionTextDecoration: widget.descriptionTextDecoration,
        );

      case "date":
        return SimpleDate(
          questions: questions,
          checklistModel: checklistModel,
          showIndex: widget.showIndex,
          dateImage: widget.dateImage,
          remarkImage: widget.remarkImage,
          index: widget.index,
          showIcon: remarks,
          descriptionTextDecoration: widget.descriptionTextDecoration,
        );
      case "file":
        return SimpleFile(
          questions: questions,
          checklistModel: checklistModel,
          showIndex: widget.showIndex,
          remarkImage: widget.remarkImage,
          index: widget.index,
          showIcon: remarks,
          descriptionTextDecoration: widget.descriptionTextDecoration,
        );

      case "text":
        return SimpleText(
          questions: questions,
          checklistModel: checklistModel,
          showIndex: widget.showIndex,
          textImage: widget.textImage,
          remarkImage: widget.remarkImage,
          index: widget.index,
          showIcon: remarks,
          descriptionTextDecoration: widget.descriptionTextDecoration,
          textFieldWidth: widget.textFieldWidth,
          textfieldDecoration: widget.textfieldDecoration,
        );

      default:
        return SizedBox();
    }
  }
}

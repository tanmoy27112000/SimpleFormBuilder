import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_form_builder/src/screens/form_builder/page/form_builder.dart';
import 'package:simple_form_builder/src/screens/form_builder/provider/form_builder_provider.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/custom_dropdown.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/description_widget.dart';
import 'package:simple_form_builder/src/screens/form_builder/widgets/simple_icon_container.dart';

import 'package:simple_form_builder/src/shared/checklistModel.dart';
import 'package:simple_form_builder/src/shared/constant.dart';
import 'package:simple_form_builder/src/shared/utils/file_upload.dart';

part 'simple_checkbox.dart';
part 'simple_date.dart';
part 'simple_datetime.dart';
part 'simple_dropdown.dart';
part 'simple_file.dart';
part 'simple_multiple.dart';
part 'simple_remark.dart';
part 'simple_text.dart';
part 'simple_time.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.questions,
    required this.remarks,
    required this.widget,
    this.checklistModel,
  }) : super(key: key);

  final Questions questions;
  final bool remarks;
  final FormBuilder widget;
  final ChecklistModel? checklistModel;

  @override
  Widget build(BuildContext context) {
    switch (questions.type) {
      case "multiple":
        return _SimpleMultiple(
          questions: questions,
          showIcon: remarks,
          showIndex: widget.showIndex,
          index: widget.index,
          checklistModel: checklistModel,
          descriptionTextDecoration: widget.descriptionTextDecoration,
          multipleimage: widget.multipleimage,
          titleTextDecoration: widget.titleTextDecoration,
          remarkImage: widget.remarkImage,
        );
      case "dropdown":
        return _SimpleDropdown(
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
        return _SimpleCheckbox(
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
        return _SimpleDateTime(
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
        return _SimpleTime(
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
        return _SimpleDate(
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
        return _SimpleFile(
          questions: questions,
          checklistModel: checklistModel,
          showIndex: widget.showIndex,
          remarkImage: widget.remarkImage,
          index: widget.index,
          showIcon: remarks,
          descriptionTextDecoration: widget.descriptionTextDecoration,
        );

      case "text":
        return _SimpleText(
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
        return SizedBox.shrink();
    }
  }
}

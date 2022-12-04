import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/shared/checklistModel.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.questions,
    this.textStyle,
  }) : super(key: key);

  final Questions questions;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (questions.description != null && questions.description?.length != 0) {
      return Text(
        questions.description!,
        style: textStyle ?? TextStyle(color: Colors.grey),
      );
    }

    return SizedBox.shrink();
  }
}

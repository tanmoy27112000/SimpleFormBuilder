import 'package:flutter/material.dart';
import 'package:simple_form_builder/global/checklistModel.dart';

descriptionWidget(Questions e, BuildContext context, TextStyle? textStyle) {
  return e.description != null && e.description!.length != 0
      ? Text(
          e.description!,
          style: textStyle ?? TextStyle(color: Colors.grey),
        )
      : SizedBox.shrink();
}

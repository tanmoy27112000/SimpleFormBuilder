import 'package:flutter/material.dart';
import 'package:simple_form_builder/global/checklistModel.dart';

descriptionWidget(Questions e, BuildContext context) {
  return e.description != null && e.description!.length != 0
      ? Text(
          e.description!,
          style: TextStyle(color: Colors.grey),
        )
      : SizedBox.shrink();
}

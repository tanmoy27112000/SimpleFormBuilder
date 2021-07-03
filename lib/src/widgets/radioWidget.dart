import 'package:flutter/material.dart';
import 'package:simple_form_builder/global/constant.dart';
import 'package:simple_form_builder/src/controllers/checklistController.dart';
import 'package:simple_form_builder/src/models/checklistModel.dart';
import 'package:simple_form_builder/src/widgets/remarkWidget.dart';

import 'package:provider/provider.dart';

Widget radioWidget(
  Questions e,
  BuildContext context,
) {
  return Consumer<ChecklistController>(
    builder: (context, myType, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16),
            child:
                Text("${myType.currentQuestions!.indexOf(e) + 1}. ${e.title}"),
          ),
          Column(
            children: e.fields!
                .map(
                  (val) => RadioListTile(
                    value: val,
                    groupValue: myType
                        .currentQuestions![myType.currentQuestions!.indexOf(e)]
                        .answer,
                    title: Text(
                      val,
                      style: TextStyle(
                        color: e.answer != val ? Colors.grey : Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: screenWidth(
                          context: context,
                          mulBy: 0.04,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      myType.setAnswer(
                          value, myType.currentQuestions!.indexOf(e));
                    },
                  ),
                )
                .toList(),
          ),
          remarkWidget(e),
        ],
      );
    },
  );
}

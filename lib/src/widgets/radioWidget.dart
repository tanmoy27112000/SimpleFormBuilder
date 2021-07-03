import 'package:flutter/material.dart';
import 'package:formbuilder/global/constant.dart';
import 'package:formbuilder/src/controllers/checklistController.dart';
import 'package:formbuilder/src/models/checklistModel.dart';
import 'package:formbuilder/src/widgets/remarkWidget.dart';

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

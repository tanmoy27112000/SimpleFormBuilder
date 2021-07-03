import 'package:flutter/material.dart';
import 'package:formbuilder/global/constant.dart';
import 'package:formbuilder/src/controllers/checklistController.dart';
import 'package:formbuilder/src/models/checklistModel.dart';
import 'package:formbuilder/src/widgets/remarkWidget.dart';

import 'package:provider/provider.dart';

Widget checkboxWidget(
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
                  (val) => CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    title: Text(
                      val,
                      style: TextStyle(
                        color: e.answer[e.fields!.indexOf(val)] != true
                            ? Colors.grey
                            : Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: screenWidth(
                          context: context,
                          mulBy: 0.04,
                        ),
                      ),
                    ),
                    value: e.answer[e.fields!.indexOf(val)],
                    onChanged: (value) {
                      // e.answer[e.fields.indexOf(val)] = value;
                      myType.setCheckBoxAnswer(
                        value,
                        myType.currentQuestions!.indexOf(e),
                        e.fields!.indexOf(val),
                      );
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

import 'package:flutter/material.dart';
import 'package:formbuilder/global/constant.dart';
import 'package:formbuilder/src/controllers/checklistController.dart';
import 'package:formbuilder/src/models/checklistModel.dart';
import 'package:formbuilder/src/widgets/remarkWidget.dart';

import 'package:provider/provider.dart';

Widget dropdownWidget(
  BuildContext context,
  Questions e,
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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24,
            ),
            child: Container(
              width: screenWidth(context: context, mulBy: 0.5),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: e.answer != null ? Colors.blue : Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: e.answer == null
                      ? Text('Filter by')
                      : Text(
                          e.answer,
                          style: TextStyle(
                            color: e.answer != null ? Colors.blue : Colors.grey,
                          ),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.grey),
                  items: e.fields!.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    myType.setAnswer(
                      value,
                      myType.currentQuestions!.indexOf(e),
                    );
                  },
                ),
              ),
            ),
          ),
          remarkWidget(e),
        ],
      );
    },
  );
}

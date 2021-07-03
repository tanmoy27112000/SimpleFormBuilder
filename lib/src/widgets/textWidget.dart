import 'package:flutter/material.dart';
import 'package:simple_form_builder/global/constant.dart';
import 'package:simple_form_builder/src/controllers/checklistController.dart';
import 'package:simple_form_builder/src/models/checklistModel.dart';
import 'package:simple_form_builder/src/widgets/remarkWidget.dart';
import 'package:provider/provider.dart';

Widget textWidget(
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
              vertical: 8.0,
              horizontal: 24,
            ),
            child: Container(
              width: screenWidth(context: context, mulBy: 0.7),
              child: TextField(
                onChanged: (value) {
                  // e.answer = value;
                  myType.setAnswer(
                    value,
                    myType.currentQuestions!.indexOf(e),
                  );
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Enter text here",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
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

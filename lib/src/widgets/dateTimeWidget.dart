import 'package:flutter/material.dart';
import 'package:formbuilder/global/constant.dart';
import 'package:formbuilder/src/controllers/checklistController.dart';
import 'package:formbuilder/src/models/checklistModel.dart';
import 'package:formbuilder/src/widgets/remarkWidget.dart';
import 'package:provider/provider.dart';

import 'customDropdownWidget.dart';

Widget dateTimeWidget(
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
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(),
                  child: Builder(
                    builder: (context) => customDropdownWidget(
                      onChanged: (val) {
                        print(val);
                      },
                      onTap: () async {
                        DateTime tempDate = await selectDate(context);

                        if (e.answer == null) {
                          myType.setAnswer(
                            tempDate,
                            myType.currentQuestions!.indexOf(e),
                          );
                        } else {
                          myType.setAnswer(
                            DateTime(
                              tempDate.year,
                              tempDate.month,
                              tempDate.day,
                              e.answer.hour,
                              e.answer.minute,
                            ),
                            myType.currentQuestions!.indexOf(e),
                          );
                        }
                      },
                      title: e.answer == null
                          ? "DD-MM-YYYY"
                          : dateFormater.format(e.answer),
                      // date != null ? dateFormater.format(date) : "DD-MM-YYYY",
                      context: context,
                      imagePath: "images/Date and Time.png",
                      showImage: true,
                      isRequired: false,
                      width: screenWidth(context: context, mulBy: 0.4),
                    ),
                  ),
                ),
                customDropdownWidget(
                  onChanged: (val) {},
                  onTap: () async {
                    TimeOfDay tempTime = await selectTime(context);

                    if (e.answer == null) {
                      myType.setAnswer(
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          tempTime.hour,
                          tempTime.minute,
                        ),
                        myType.currentQuestions!.indexOf(e),
                      );
                    } else {
                      myType.setAnswer(
                        DateTime(
                          e.answer.year,
                          e.answer.month,
                          e.answer.day,
                          tempTime.hour,
                          tempTime.minute,
                        ),
                        myType.currentQuestions!.indexOf(e),
                      );
                    }

                    // reminderController.updateIschanged(true);
                  },
                  title: e.answer != null
                      ? formatTimeOfDay(TimeOfDay.fromDateTime(e.answer))
                      : "Hr:Mins",
                  context: context,
                  showImage: false,
                  isRequired: false,
                  width: screenWidth(context: context, mulBy: 0.3),
                ),
              ],
            ),
          ),
          remarkWidget(e),
        ],
      );
    },
  );
}

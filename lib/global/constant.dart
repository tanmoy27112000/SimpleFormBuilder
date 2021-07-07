import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

DateFormat dateFormater = new DateFormat('dd-MM-yyyy');

double screenWidth({var context, double? mulBy}) {
  return MediaQuery.of(context).size.width * mulBy!;
}

double screenHeight({var context, double? mulBy}) {
  return MediaQuery.of(context).size.height * mulBy!;
}

selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), // Refer step 1
    firstDate: DateTime.now(),
    lastDate: DateTime(2025),
  );
  if (picked != null) return picked;
}

selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  return result;
}

selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) return picked;
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

Map<String, dynamic> sampleData = {
  "status": 1,
  "data": [
    {
      "questions": [
        {
          "question_id": "60e0a77c10926d0f006834a0",
          "fields": ["abvoe 40km/h", "below 40km/h", "0km/h"],
          "_id": "60dc6a3dc9fe14577c30d271",
          "title": "Please provide the speed of vehicle?",
          "description": "please select one option given below",
          "remark": true,
          "type": "multiple",
          "is_mandatory": true
        },
        {
          "question_id": "60e0a77c10926d0f006834a1",
          "fields": [
            "0km/h",
            "10km/h",
            "20km/h",
            "30km/h",
            "40km/h",
            "50km/h",
            "60km/h",
            "70km/h",
            "80km/h"
          ],
          "_id": "60dc6a3dc9fe14577c30d272",
          "title": "Please provide the high speed of vehicle?",
          "description": "please select one option given below",
          "remark": false,
          "type": "dropdown",
          "is_mandatory": true
        },
        {
          "question_id": "60e0a77c10926d0f006834a2",
          "fields": ["20km/h", "30km/h", "40km/h", "50km/h", "70km/h"],
          "_id": "60dc6a3dc9fe14577c30d273",
          "title": "Please provide the speed of vehicle past 1 hour?",
          "description": "please select one or more options given below",
          "remark": false,
          "type": "checkbox",
          "is_mandatory": true
        },
        {
          "question_id": "60e0a77c10926d0f006834a3",
          "fields": [],
          "_id": "60dc6a3dc9fe14577c30d274",
          "title": "Please provide the date of vehicle registration?",
          "description": "",
          "remark": false,
          "type": "date",
          "is_mandatory": true
        },
        {
          "question_id": "60e0a77c10926d0f006834a4",
          "fields": [],
          "_id": "60dc6a3dc9fe14577c30d275",
          "title": "Please upload the vehicle registration paper",
          "description": "",
          "type": "file",
          "remark": false,
          "is_mandatory": true
        },
        {
          "question_id": "60e0a77c10926d0f006834a5",
          "fields": [300],
          "_id": "60dc6a3dc9fe14577c30d276",
          "title": "Write about vehicle condition",
          "description": "",
          "type": "text",
          "remark": false,
          "is_mandatory": true
        }
      ]
    },
  ]
};

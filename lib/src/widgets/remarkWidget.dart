import 'package:flutter/material.dart';
import 'package:formbuilder/src/models/checklistModel.dart';

Widget remarkWidget(Questions e) {
  return e.remark
      ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 20,
                      width: 20,
                      child: Image(
                        image: AssetImage(
                          "images/message.png",
                        ),
                      ),
                    ),
                  ),
                  Text("Enter remarks"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      e.remarkData = value;
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: "Enter your remarks",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        )
      : SizedBox.shrink();
}

import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/shared/checklistModel.dart';
import 'package:simple_form_builder/src/shared/constant.dart';

import 'description_widget.dart';
import 'simple_icon_container.dart';
import 'simple_remark.dart';

class SimpleText extends StatefulWidget {
  const SimpleText({
    Key? key,
    required this.questions,
    this.checklistModel,
    required this.showIndex,
    this.textImage,
    this.remarkImage,
    required this.index,
    required this.showIcon,
    this.descriptionTextDecoration,
    this.textFieldWidth,
    this.textfieldDecoration,
  }) : super(key: key);

  final Questions questions;
  final ChecklistModel? checklistModel;
  final bool showIndex;
  final String? textImage;
  final String? remarkImage;
  final int index;
  final bool showIcon;
  final TextStyle? descriptionTextDecoration;
  final double? textFieldWidth;
  final InputDecoration? textfieldDecoration;

  @override
  State<SimpleText> createState() => _SimpleTextState();
}

class _SimpleTextState extends State<SimpleText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.showIcon
                  ? IconContainer(icon: widget.textImage)
                  : Container(),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                    "${widget.showIndex ? "${widget.checklistModel!.data![widget.index].questions!.indexOf(widget.questions) + 1}. " : ""}${widget.questions.title}"),
              ),
              DescriptionWidget(
                questions: widget.questions,
                textStyle: widget.descriptionTextDecoration,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: Container(
            width: screenWidth(
                context: context,
                mulBy: widget.textFieldWidth == null
                    ? 0.9
                    : widget.textFieldWidth),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  maxLines: widget.questions.maxline,
                  onChanged: (value) {
                    // e.answer = value;
                    setState(() {
                      widget.questions.answer = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: widget.textfieldDecoration ??
                      InputDecoration.collapsed(
                        hintText: "Enter text here",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
        RemarkWidget(
          questions: widget.questions,
          remark: widget.showIcon,
          icon: widget.remarkImage,
          onChanged: (value) {
            widget.questions.remarkData = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}

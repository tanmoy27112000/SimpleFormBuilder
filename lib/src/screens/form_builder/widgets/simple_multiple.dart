import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/shared/checklistModel.dart';

import 'description_widget.dart';
import 'simple_icon_container.dart';
import 'simple_remark.dart';

class SimpleMultiple extends StatefulWidget {
  const SimpleMultiple({
    Key? key,
    required this.questions,
    this.checklistModel,
    required this.showIcon,
    required this.showIndex,
    required this.index,
    this.title,
    this.descriptionTextDecoration,
    this.multipleimage,
    this.titleTextDecoration,
    this.remarkImage,
  }) : super(key: key);

  final Questions questions;
  final ChecklistModel? checklistModel;
  final bool showIcon;
  final bool showIndex;
  final int index;
  final String? title;
  final TextStyle? descriptionTextDecoration;
  final String? multipleimage;
  final TextStyle? titleTextDecoration;
  final String? remarkImage;

  @override
  State<SimpleMultiple> createState() => _SimpleMultipleState();
}

class _SimpleMultipleState extends State<SimpleMultiple> {
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
                  ? IconContainer(icon: widget.multipleimage)
                  : Container(),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "${widget.showIndex ? "${widget.checklistModel!.data![widget.index].questions!.indexOf(widget.questions) + 1}. " : ""}${widget.questions.title}",
                  style: widget.titleTextDecoration ?? TextStyle(),
                ),
              ),
              DescriptionWidget(
                questions: widget.questions,
                textStyle: widget.descriptionTextDecoration,
              ),
            ],
          ),
        ),
        Column(
          children: widget.questions.fields!
              .map(
                (val) => RadioListTile(
                  value: val,
                  groupValue: widget.questions.answer,
                  title: Text(
                    val,
                    style: TextStyle(
                        color: widget.questions.answer != val
                            ? Colors.grey
                            : Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15),
                  ),
                  onChanged: (value) {
                    widget.questions.answer = value;
                    setState(() {});
                  },
                ),
              )
              .toList(),
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

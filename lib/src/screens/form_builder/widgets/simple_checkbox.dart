import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/shared/checklistModel.dart';

import 'description_widget.dart';
import 'simple_icon_container.dart';
import 'simple_remark.dart';

class SimpleCheckbox extends StatefulWidget {
  const SimpleCheckbox({
    Key? key,
    required this.questions,
    this.checklistModel,
    required this.showIndex,
    this.checkboxImage,
    this.remarkImage,
    required this.index,
    required this.showIcon,
    this.descriptionTextDecoration,
  }) : super(key: key);

  final Questions questions;
  final ChecklistModel? checklistModel;
  final bool showIndex;
  final String? checkboxImage;
  final String? remarkImage;
  final int index;
  final bool showIcon;
  final TextStyle? descriptionTextDecoration;

  @override
  State<SimpleCheckbox> createState() => _SimpleCheckboxState();
}

class _SimpleCheckboxState extends State<SimpleCheckbox> {
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
                  ? IconContainer(icon: widget.checkboxImage)
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
        Column(
          children: widget.questions.fields!
              .map(
                (val) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  title: Text(
                    val,
                    style: TextStyle(
                        color: widget.questions.answer[
                                    widget.questions.fields!.indexOf(val)] !=
                                true
                            ? Colors.grey
                            : Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15),
                  ),
                  value: widget
                      .questions.answer[widget.questions.fields!.indexOf(val)],
                  onChanged: (value) {
                    widget.questions
                        .answer[widget.questions.fields!.indexOf(val)] = value;
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

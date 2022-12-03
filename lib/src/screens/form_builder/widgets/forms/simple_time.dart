part of 'question_widget.dart';

class _SimpleTime extends StatefulWidget {
  const _SimpleTime({
    Key? key,
    required this.questions,
    this.checklistModel,
    required this.showIndex,
    this.dateImage,
    this.remarkImage,
    required this.index,
    required this.showIcon,
    this.descriptionTextDecoration,
  }) : super(key: key);

  final Questions questions;
  final ChecklistModel? checklistModel;
  final bool showIndex;
  final String? dateImage;
  final String? remarkImage;
  final int index;
  final bool showIcon;
  final TextStyle? descriptionTextDecoration;

  @override
  State<_SimpleTime> createState() => _SimpleTimeState();
}

class _SimpleTimeState extends State<_SimpleTime> {
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
                  ? IconContainer(icon: widget.dateImage)
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
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              CustomDropdown(
                onChanged: (val) {},
                onTap: () async {
                  TimeOfDay tempTime = await selectTime(context);

                  if (widget.questions.answer == null) {
                    setState(() {
                      widget.questions.answer = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        tempTime.hour,
                        tempTime.minute,
                      );
                    });
                  } else {
                    setState(() {
                      widget.questions.answer = DateTime(
                        widget.questions.answer.year,
                        widget.questions.answer.month,
                        widget.questions.answer.day,
                        tempTime.hour,
                        tempTime.minute,
                      );
                    });
                  }

                  // reminderController.updateIschanged(true);
                },
                title: widget.questions.answer != null
                    ? formatTimeOfDay(
                        TimeOfDay.fromDateTime(widget.questions.answer))
                    : "Hr:Mins",
                showImage: false,
                isRequired: false,
                width: screenWidth(context: context, mulBy: 0.3),
              ),
            ],
          ),
        ),
        _RemarkWidget(
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

part of 'question_widget.dart';

class _SimpleTime extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showIcon ? IconContainer(icon: dateImage) : Container(),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                    "${showIndex ? "${checklistModel!.data![index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}"),
              ),
              DescriptionWidget(
                questions: questions,
                textStyle: descriptionTextDecoration,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              Consumer<FormBuilderProvider>(
                builder: (context, value, child) {
                  return CustomDropdown(
                    onChanged: (val) {},
                    onTap: () async {
                      TimeOfDay tempTime = await selectTime(context);

                      if (questions.answer == null) {
                        value.setAnswer(
                          questions: questions,
                          value: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            tempTime.hour,
                            tempTime.minute,
                          ),
                          index: index,
                        );
                      } else {
                        value.setAnswer(
                          questions: questions,
                          value: DateTime(
                            questions.answer.year,
                            questions.answer.month,
                            questions.answer.day,
                            tempTime.hour,
                            tempTime.minute,
                          ),
                          index: index,
                        );
                      }
                      // reminderController.updateIschanged(true);
                    },
                    title: questions.answer != null
                        ? formatTimeOfDay(
                            TimeOfDay.fromDateTime(questions.answer))
                        : "Hr:Mins",
                    showImage: false,
                    isRequired: false,
                    width: screenWidth(context: context, mulBy: 0.3),
                  );
                },
              ),
            ],
          ),
        ),
        Consumer<FormBuilderProvider>(
          builder: ((context, value, child) {
            return _RemarkWidget(
              questions: questions,
              remark: showIcon,
              icon: remarkImage,
              onChanged: (input) {
                value.setRemark(questions, input, index);
              },
            );
          }),
        ),
      ],
    );
  }
}

part of 'question_widget.dart';

class _SimpleCheckbox extends StatelessWidget {
  const _SimpleCheckbox({
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showIcon ? IconContainer(icon: checkboxImage) : Container(),
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
        Column(
          children: questions.fields!
              .map(
                (checked) => Consumer<FormBuilderProvider>(
                  builder: (context, value, child) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      title: Text(
                        checked,
                        style: TextStyle(
                            color: questions.answer[
                                        questions.fields!.indexOf(checked)] !=
                                    true
                                ? Colors.grey
                                : Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                      value:
                          questions.answer[questions.fields!.indexOf(checked)],
                      onChanged: (input) {
                        value.setCheckboxAnswers(
                          questions: questions,
                          input: input,
                          checked: checked,
                          index: index,
                        );
                      },
                    );
                  },
                ),
              )
              .toList(),
        ),
        Consumer<FormBuilderProvider>(
          builder: (context, value, child) {
            return _RemarkWidget(
              questions: questions,
              remark: showIcon,
              icon: remarkImage,
              onChanged: (input) {
                value.setRemark(questions, input, index);
              },
            );
          },
        ),
      ],
    );
  }
}

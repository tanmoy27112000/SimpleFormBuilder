part of 'question_widget.dart';

class _SimpleMultiple extends StatelessWidget {
  const _SimpleMultiple({
    Key? key,
    required this.questions,
    required this.showIcon,
    required this.showIndex,
    required this.index,
    this.checklistModel,
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
  final TextStyle? descriptionTextDecoration;
  final String? multipleimage;
  final TextStyle? titleTextDecoration;
  final String? remarkImage;

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
              showIcon ? IconContainer(icon: multipleimage) : Container(),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "${showIndex ? "${checklistModel!.data![index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}",
                  style: titleTextDecoration ?? TextStyle(),
                ),
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
                (val) => Consumer<FormBuilderProvider>(
                  builder: (context, value, child) {
                    return RadioListTile(
                      value: val,
                      groupValue: questions.answer,
                      title: Text(
                        val,
                        style: TextStyle(
                            color: questions.answer != val
                                ? Colors.grey
                                : Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                      onChanged: (input) {
                        value.setAnswer(
                          questions: questions,
                          value: input,
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

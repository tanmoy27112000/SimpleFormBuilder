part of 'question_widget.dart';

class _SimpleDropdown extends StatelessWidget {
  _SimpleDropdown({
    Key? key,
    required this.questions,
    required this.showIndex,
    required this.index,
    required this.showIcon,
    this.remarkImage,
    this.checklistModel,
    this.dropdownImage,
    this.descriptionTextDecoration,
  }) : super(key: key);

  final Questions questions;
  final ChecklistModel? checklistModel;
  final bool showIndex;
  final String? dropdownImage;
  final String? remarkImage;
  final int index;
  final bool showIcon;
  final TextStyle? descriptionTextDecoration;

  @override
  Widget build(BuildContext context) {
    print("Does it reprint?");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showIcon ? IconContainer(icon: dropdownImage) : Container(),
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
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24,
          ),
          child: Container(
            width: screenWidth(context: context, mulBy: 0.9),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: questions.answer != null ? Colors.blue : Colors.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<FormBuilderProvider>(
                builder: ((context, value, child) {
                  return DropdownButton(
                    underline: SizedBox(),
                    hint: questions.answer == null
                        ? Text('Select option')
                        : Text(
                            questions.answer,
                            style: TextStyle(
                              color: questions.answer != null
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.grey),
                    items: questions.fields!.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (input) {
                      value.setAnswer(questions, input, index);
                    },
                  );
                }),
              ),
            ),
          ),
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
        )
      ],
    );
  }
}

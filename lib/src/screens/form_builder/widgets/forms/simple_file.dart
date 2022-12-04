part of 'question_widget.dart';

class _SimpleFile extends StatelessWidget {
  const _SimpleFile({
    Key? key,
    required this.questions,
    this.checklistModel,
    required this.showIndex,
    this.remarkImage,
    required this.index,
    required this.showIcon,
    this.descriptionTextDecoration,
  }) : super(key: key);

  final Questions questions;
  final ChecklistModel? checklistModel;
  final bool showIndex;
  final String? remarkImage;
  final int index;
  final bool showIcon;
  final TextStyle? descriptionTextDecoration;

  @override
  Widget build(BuildContext context) {
    print("object");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                    "${showIndex ? "${checklistModel!.data![index].questions!.indexOf(questions) + 1}. " : ""}${questions.title}"),
              ),
            ),
            DescriptionWidget(
              questions: questions,
              textStyle: descriptionTextDecoration,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 70,
                      width: 100,
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.grey[500],
                        size: 70,
                      ),
                    ),
                    questions.answer != null
                        ? CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 15,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              Consumer<FormBuilderProvider>(
                builder: (context, value, child) {
                  return TextButton(
                    onPressed: () => fileUpload(
                        context: context,
                        files: (files) {
                          value.setAnswer(
                            questions: questions,
                            value: files,
                            index: index,
                          );
                        }),
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  );
                },
              )
            ],
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

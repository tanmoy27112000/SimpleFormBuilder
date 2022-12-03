part of 'question_widget.dart';

class _SimpleFile extends StatefulWidget {
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
  State<_SimpleFile> createState() => _SimpleFileState();
}

class _SimpleFileState extends State<_SimpleFile> {
  @override
  Widget build(BuildContext context) {
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
                    "${widget.showIndex ? "${widget.checklistModel!.data![widget.index].questions!.indexOf(widget.questions) + 1}. " : ""}${widget.questions.title}"),
              ),
            ),
            DescriptionWidget(
              questions: widget.questions,
              textStyle: widget.descriptionTextDecoration,
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
                    widget.questions.answer != null
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
              TextButton(
                onPressed: () => fileUpload(
                  context: context,
                  files: (files) => setState(
                    () => widget.questions.answer = files,
                  ),
                ),
                child: Text(
                  "Upload",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
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

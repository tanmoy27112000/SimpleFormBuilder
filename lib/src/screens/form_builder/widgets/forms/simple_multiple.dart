part of 'question_widget.dart';

class _SimpleMultiple extends StatefulWidget {
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
  State<_SimpleMultiple> createState() => _SimpleMultipleState();
}

class _SimpleMultipleState extends State<_SimpleMultiple> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormBuilderProvider>();

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
                    provider.setAnswer(widget.questions, value, widget.index);
                  },
                ),
              )
              .toList(),
        ),
        _RemarkWidget(
          questions: widget.questions,
          remark: widget.showIcon,
          icon: widget.remarkImage,
          onChanged: (value) {
            provider.setRemark(widget.questions, value, widget.index);
          },
        ),
      ],
    );
  }
}

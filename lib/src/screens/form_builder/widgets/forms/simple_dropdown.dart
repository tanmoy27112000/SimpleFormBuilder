part of 'question_widget.dart';

class _SimpleDropdown extends StatefulWidget {
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
  State<_SimpleDropdown> createState() => _SimpleDropdownState();
}

class _SimpleDropdownState extends State<_SimpleDropdown> {
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
                  ? IconContainer(icon: widget.dropdownImage)
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
                color:
                    widget.questions.answer != null ? Colors.blue : Colors.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                underline: SizedBox(),
                hint: widget.questions.answer == null
                    ? Text('Select option')
                    : Text(
                        widget.questions.answer,
                        style: TextStyle(
                          color: widget.questions.answer != null
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.grey),
                items: widget.questions.fields!.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.questions.answer = value;
                  });
                },
              ),
            ),
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
        )
      ],
    );
  }
}

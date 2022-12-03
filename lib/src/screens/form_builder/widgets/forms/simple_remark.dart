part of 'question_widget.dart';

class _RemarkWidget extends StatelessWidget {
  const _RemarkWidget({
    Key? key,
    required this.questions,
    required this.remark,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  final Questions questions;
  final bool remark;
  final String? icon;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (questions.remark) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                remark == false
                    ? SizedBox(
                        width: 16,
                      )
                    : icon == null
                        ? Container(
                            padding: EdgeInsets.only(left: 16),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Image.asset(
                              icon!,
                              height: 20,
                            ),
                          ),
                Text("Enter remarks"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: onChanged,
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter your remarks",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Container();
  }
}

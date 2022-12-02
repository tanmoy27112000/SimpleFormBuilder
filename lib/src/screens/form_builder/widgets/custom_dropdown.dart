import 'package:flutter/material.dart';
import 'package:simple_form_builder/src/shared/constant.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    this.showImage = true,
    required this.onChanged,
    required this.title,
    this.isRequired = true,
    this.droplist,
    this.width,
    this.dropVal,
    this.onTap,
  }) : super(key: key);

  final bool showImage;
  final Function? onChanged;
  final String? title;
  final bool isRequired;
  final List? droplist;
  final double? width;
  final String? dropVal;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        showImage
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 25,
                  width: 25,
                ),
              )
            : SizedBox.shrink(),
        Stack(
          children: [
            Container(
              width: width ?? screenWidth(context: context, mulBy: 0.7),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton(
                  icon: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  value: dropVal,
                  hint: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      isRequired
                          ? Text(
                              "* ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )
                          : Text(""),
                      Text(
                        title!,
                        style: TextStyle(
                          color: onTap != null
                              ? Colors.grey[800]
                              : Colors.grey[700],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth(
                      context: context,
                      mulBy: 0.04,
                    ),
                  ),
                  items: droplist != null
                      ? droplist?.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList()
                      : ['All', 'Two', 'Three'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                  onChanged: (val) {
                    onChanged!(val);
                  },
                ),
              ),
            ),
            onTap == null
                ? SizedBox.shrink()
                : InkWell(
                    onTap: () => onTap!(),
                    child: Container(
                      width: width ??
                          screenWidth(
                            context: context,
                            mulBy: 0.7,
                          ),
                      height: 50,
                    ),
                  )
          ],
        ),
      ],
    );
  }
}

// Row customDropdownWidget({
//   BuildContext? context,
//   bool showImage = true,
//   @required Function? onChanged,
//   @required String? title,
//   bool isRequired = true,
//   List? droplist,
//   double? width,
//   String? dropVal,
//   Function? onTap,
// }) {
//   return 
// }

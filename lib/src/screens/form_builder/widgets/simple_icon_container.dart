import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({Key? key, this.icon}) : super(key: key);

  final String? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Image.asset(
        icon!,
        height: 20,
      ),
    );
  }
}

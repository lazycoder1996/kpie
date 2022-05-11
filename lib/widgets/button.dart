import 'package:flutter/material.dart';
import 'package:kpie/utils/constants.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final Color? borderColor;
  final double? borderWidth;
  final TextStyle? textStyle;
  const MyButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.borderColor,
    this.borderWidth,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: child,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        textStyle: textStyle,
        side: BorderSide(
          color: borderColor ?? Colors.black,
          width: borderWidth ?? 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

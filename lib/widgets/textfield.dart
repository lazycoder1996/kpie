import 'package:flutter/material.dart';
import 'package:kpie/utils/constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String labelText;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;
  const MyTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.padding,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: (val) {},
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}

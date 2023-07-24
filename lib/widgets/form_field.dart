import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.errorText,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.labelText,
    this.obscureText,
  }) : super(key: key);

  final String hintText;
  final String? labelText;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
      ),
      obscureText: obscureText != null ? obscureText! : false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AppTextField extends StatefulWidget {
  final String errorText;
  final String hintText;
  final bool checkNumber;
  final void Function(String)? onChanged;

  final TextEditingController controller;

  const AppTextField({
    super.key,
    required this.checkNumber,
    required this.hintText,
    required this.errorText,
    required this.controller, this.onChanged,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 30,
      controller: widget.controller,
      keyboardType: widget.checkNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: widget.checkNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      onChanged: (value) {
        if (widget.checkNumber) {
          setState(() {
            showError = value.length < 13;
          });
        } else {
          setState(() {
            showError = !value.contains('@');
            showError = value.length<3;
          });
        }
      },
      decoration: InputDecoration(

        counterText: "",
        hintText: widget.hintText,
        errorText: showError ? widget.errorText : null,
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}

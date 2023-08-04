import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final String? hintText;
  final String? errorText;
  final bool onlyNumber;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.text,
    required this.controller,
    this.hintText,
    this.onlyNumber = false,
    this.errorText,
    this.onChanged,
    this.validator,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          inputFormatters: widget.onlyNumber == true
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ]
              : [],
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            errorText: widget.errorText,
          ),
        )
      ],
    );
  }
}

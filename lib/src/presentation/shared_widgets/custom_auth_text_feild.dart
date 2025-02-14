import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
    this.isPasswordVisible = true,
    this.showPassword,
    this.onChanged,
    this.custfocusNode,
  });

  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  bool isPasswordVisible;
  void Function()? showPassword;
  void Function(String)? onChanged;
  final FocusNode? custfocusNode;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // Focus node to track the focus of the TextFormField
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // Listen to focus changes
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSummaryField = widget.labelText == "Summary";

    return TextFormField(
      focusNode: widget.custfocusNode ?? _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: (_isFocused && widget.showPassword != null)
            ? IconButton(
                onPressed: widget.showPassword,
                icon: Icon(
                  widget.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off, // Toggle icon based on visibility
                  color: Colors.grey.shade600,
                ),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: _isFocused ? Colors.grey.shade600 : Colors.grey.shade400,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
        filled: true, // Add filled background
        fillColor: const Color(0xFFF4F4F4),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFFDEDEDE), // Match background color
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText:
          widget.showPassword == null ? false : widget.isPasswordVisible,
      validator: widget.validator,
      keyboardType:
          isSummaryField ? TextInputType.multiline : widget.keyboardType,
      maxLines:
          isSummaryField ? 5 : 1, // Set maxLines to 5 if it's the Summary field
      style: TextStyle(
        color: Color(0xFF858383),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? errorMessage;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  bool showSuffixIcon = false;

  TextFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    required this.errorMessage,
    this.obscureText = false,
    this.keyboardType,
    this.showSuffixIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: (value) {
        if (value == null || value.isEmpty) {

        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: showSuffixIcon
        // error icon with error message when hover on it
            ?
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage!),
              ),
            );
          },
          icon: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          )
        )

            : null,

        labelText: label,
        border: OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }


}
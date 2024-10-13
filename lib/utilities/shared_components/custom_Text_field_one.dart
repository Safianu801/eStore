import 'package:flutter/material.dart';

class CustomTextFieldOne extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData iconData;
  final IconButton? suffixIcon;
  final bool isObscure;
  final Function(String)? onChange;
  const CustomTextFieldOne({super.key, required this.hintText, required this.controller, required this.iconData, this.suffixIcon, required this.isObscure, this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      onChanged: onChange,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent, width: 0)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.transparent, width: 0)
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12
        ),
        prefixIcon: Icon(iconData, size: 22,),
        suffixIcon: suffixIcon,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        contentPadding: const EdgeInsets.all(0.5)
      ),
    );
  }
}

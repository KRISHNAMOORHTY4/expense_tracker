import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final IconData ? iconData;
  final TextEditingController controller;
  final TextInputType keyBoardType;

  const CustomTextField({super.key, required this.title, required this.keyBoardType,  this.iconData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value){
        if(value==null || value.isEmpty){
          return "Please Add $title";
        }
        return null;
      },
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        prefixIcon: iconData==null ? null : Icon(iconData),
        hintText: "Add $title",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF6C63FF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }


}

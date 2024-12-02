import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintTxt,
    required this.controller,
    this.minLines,
    this.maxLines,
  });
  final String hintTxt;
  final int? minLines;
  final int? maxLines;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintTxt,
        hintStyle: const TextStyle(color: AppColors.kAsh),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.kWhite),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.kred),
        ),
      ),
    );
  }
}

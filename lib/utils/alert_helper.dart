import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_text.dart';
import 'package:todo_app/utils/app_colors.dart';

class AlertHelper {
  static void showSuccessMessage(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(content: CustomText(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorMessage(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: CustomText(
        message,
        color: AppColors.kWhite,
      ),
      backgroundColor: AppColors.kred,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

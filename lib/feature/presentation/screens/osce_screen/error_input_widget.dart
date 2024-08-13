import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/strings/app_strings.dart';

class ErrorInputWidget extends StatelessWidget {
  const ErrorInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.color4A148C,
            AppColors.colorFF1976D2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 48.0, // Adjust the size as needed
            ),
            SizedBox(height: 16.0), // Space between the icon and the text
            Text(
              AppStrings.errorInput,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Adjust the font weight as needed
              ),
              textAlign: TextAlign.center, // Center the text horizontally
            ),
          ],
        ),
      ),
    );
  }
}
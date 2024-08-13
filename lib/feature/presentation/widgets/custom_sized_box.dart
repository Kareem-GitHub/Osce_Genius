import 'package:flutter/material.dart';

class CustomHeightSizedBox extends StatelessWidget {
  const CustomHeightSizedBox({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * height);
  }
}

class CustomWidthSizedBox extends StatelessWidget {
  const CustomWidthSizedBox({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.width * width);
  }
}

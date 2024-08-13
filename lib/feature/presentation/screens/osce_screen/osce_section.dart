import 'package:flutter/material.dart';
import 'package:osce_genius/core/constants/colors/app_colors.dart';

class OSCESection extends StatelessWidget {
  final String title;
  final List<String>? items;

  const OSCESection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: AppColors.colorWhite),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ...items!.map(
          (item) => Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '- ',
                  style: TextStyle(color: AppColors.colorWhite, fontSize: 14),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: AppColors.colorWhite,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}

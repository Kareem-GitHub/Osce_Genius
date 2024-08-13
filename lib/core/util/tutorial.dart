import 'package:flutter/material.dart';
import 'package:osce_genius/core/constants/colors/app_colors.dart';
import 'package:osce_genius/core/constants/strings/app_strings.dart';
import 'package:osce_genius/core/theme/text_styles.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


class Tutorial {
  List<TargetFocus> targets = [];
  bool isInitialized = false;
void initTargets(GlobalKey inputPromptKey, GlobalKey checkboxKey, double horizontalPadding) {
  if (isInitialized) return;
  targets.add(TargetFocus(
    identify: AppStrings.inputPromptKey,
    keyTarget: inputPromptKey,
    shape: ShapeLightFocus.RRect,
    contents: [
      TargetContent(
        align: ContentAlign.bottom,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: const Text(
            AppStrings.inputPromptTutorial,
            style: AppTxtStyles.tutorialTxtStyle,
          ),
        ),
      ),
    ],
  ));

  targets.add(TargetFocus(
    identify: AppStrings.checkBoxKey,
    keyTarget: checkboxKey,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: const Text(
            AppStrings.checkBoxTutorial,
            style: AppTxtStyles.tutorialTxtStyle,
          ),
        ),
      ),
    ],
  ));
  isInitialized = true;
}


  void showTutorial(BuildContext context) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: AppColors.colorBlack,
      textSkip: AppStrings.skip,
      paddingFocus: 10,
      opacityShadow: 0.8,
    ).show(context: context);
  }
}
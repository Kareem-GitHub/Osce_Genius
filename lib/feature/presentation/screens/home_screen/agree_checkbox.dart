import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osce_genius/core/constants/colors/app_colors.dart';
import 'package:osce_genius/core/constants/strings/app_strings.dart';
import 'package:osce_genius/core/theme/text_styles.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_bloc.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_event.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_state.dart';

class AgreeCheckbox extends StatelessWidget {
  final GlobalKey checkboxKey;

  const AgreeCheckbox({
    super.key,
    required this.checkboxKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromptBloc, PromptState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  key: checkboxKey,
                  value: state.isCheckboxChecked,
                  onChanged: (value) {
                    context
                        .read<PromptBloc>()
                        .add(CheckboxChangedEvent(value ?? false));
                  },
                ),
                const Expanded(
                  child: Text(
                    AppStrings.iAgreeToTheTerms,
                    style: TextStyle(color: AppColors.colorWhite),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04),
              child: const Center(
                child: Text(
                  AppStrings.terms,
                  textAlign: TextAlign.center,
                  style: AppTxtStyles.termsTxtStyle
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

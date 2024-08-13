import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osce_genius/core/constants/colors/app_colors.dart';
import 'package:osce_genius/core/constants/strings/app_strings.dart';
import 'package:osce_genius/core/theme/text_styles.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_bloc.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_state.dart';

import '../../blocs/prompt_bloc/prompt_event.dart';

class GenerateOsceButton extends StatelessWidget {
  final TextEditingController textController;
  final File? image;

  const GenerateOsceButton({
    super.key,
    required this.textController,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromptBloc, PromptState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isButtonEnabled
              ? () {
                  final promptBloc = context.read<PromptBloc>();
                  promptBloc.add(GenerateOsceEvent());

                  Navigator.of(context).pushNamed(('/osce')
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.colorBlack,
          ),
          child: const Text(
            AppStrings.generateOSCE,
            style: AppTxtStyles.buttonTxtStyle,
          ),
        );
      },
    );
  }
}

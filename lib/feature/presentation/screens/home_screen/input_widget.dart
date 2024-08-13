import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../blocs/prompt_bloc/prompt_bloc.dart';
import '../../blocs/prompt_bloc/prompt_event.dart';
import '../../blocs/prompt_bloc/prompt_state.dart';
import '../../widgets/custom_sized_box.dart';

class InputWidget extends StatefulWidget {
  final GlobalKey inputPromptKey;
  final TextEditingController textController;

  const InputWidget({
    required this.inputPromptKey,
    required this.textController,
    super.key,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromptBloc, PromptState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              key: widget.inputPromptKey,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.textController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.textFieldDisabledBorderColor,
                        ),
                      ),
                      labelText: 'Enter text or image',
                      labelStyle: AppTxtStyles.txtInputLabel,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.colorWhite),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.colorBlue),
                      ),
                    ),
                    enabled: state.isTextInputEnabled,
                    onChanged: (text) {
                      context.read<PromptBloc>().add(TextChangedEvent(text));
                    },
                  ),
                ),
                const CustomWidthSizedBox(width: 0.02),
                IconButton(
                  icon: Icon(
                    Icons.image,
                    color: state.isImageIconEnabled
                        ? AppColors.colorWhite
                        : AppColors.colorGrey,
                  ),
                  onPressed: state.isImageIconEnabled
                      ? () {
                          context.read<PromptBloc>().add(PickImageEvent());
                        }
                      : null,
                ),
              ],
            ),
            if (state.image != null)
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04),
                child: Center(
                  child: Stack(
                    children: [
                      Image.file(
                        state.image!,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.read<PromptBloc>().add(ClearImageEvent());
                          },
                          child: Container(
                            color: AppColors.colorBlack54,
                            child: const Icon(
                              Icons.cancel,
                              color: AppColors.colorWhite,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:osce_genius/core/constants/colors/app_colors.dart';
import 'package:osce_genius/core/constants/strings/app_strings.dart';
import 'package:osce_genius/core/util/tutorial.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_event.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_bloc.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_state.dart';
import 'package:osce_genius/feature/presentation/widgets/custom_sized_box.dart';
import 'input_widget.dart';
import 'agree_checkbox.dart';
import 'generate_button.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorial = useMemoized(() => Tutorial());
    final textController = useTextEditingController();
    final inputPromptKey = useMemoized(() => GlobalKey());
    final checkboxKey = useMemoized(() => GlobalKey());

    useEffect(() {
      void onTextChanged() {
        context.read<PromptBloc>().add(TextChangedEvent(textController.text));
      }

      textController.addListener(onTextChanged);
      return () => textController.removeListener(onTextChanged);
    }, [textController]);

    tutorial.initTargets(
        inputPromptKey, checkboxKey, MediaQuery.of(context).size.width * 0.03);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.inputPrompt),
        backgroundColor: AppColors.colorPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => tutorial.showTutorial(context),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
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
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          BlocListener<PromptBloc, PromptState>(
                            listener: (context, state) {
                              if (state.image != null) {
                                context
                                    .read<PromptBloc>()
                                    .add(ImagePickedEvent(state.image));
                              }
                            },
                            child: InputWidget(
                              inputPromptKey: inputPromptKey,
                              textController: textController,
                            ),
                          ),
                          const CustomHeightSizedBox(height: 0.04),
                          AgreeCheckbox(checkboxKey: checkboxKey),
                          const CustomHeightSizedBox(height: 0.04),
                          GenerateOsceButton(
                            textController: textController,
                            image: context.watch<PromptBloc>().state.image,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

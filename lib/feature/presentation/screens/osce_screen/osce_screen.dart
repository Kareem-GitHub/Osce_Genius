import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osce_genius/core/constants/colors/app_colors.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_bloc.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_state.dart';
import 'package:osce_genius/feature/presentation/screens/osce_screen/error_input_widget.dart';
import 'osce_section.dart'; // Import the new OSCESection widget

class OsceScreen extends StatelessWidget {
  const OsceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated OSCE'),
        backgroundColor: AppColors.colorPurple,
      ),
      body: BlocBuilder<PromptBloc, PromptState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Container(
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
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state.osce != null) {
            final osce = state.osce!;
            return Container(
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
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                itemBuilder: (context, index) {
                  final sections = [
                    OSCESection(
                      title: 'Historical Illness Questions',
                      items: osce.historicalIllnessQuestions,
                    ),
                    OSCESection(
                      title: 'Clinical Examinations To Be Performed',
                      items: osce.clinicalExaminationsToBePerformed,
                    ),
                    OSCESection(
                      title: 'Bedside Investigations To Be Performed',
                      items: osce.bedsideInvestigationsToBePerformed,
                    ),
                    OSCESection(
                      title: 'Initial Lab Investigations',
                      items: osce.initialLabInvestigations,
                    ),
                    OSCESection(
                      title: 'Any Additional Investigations',
                      items: osce.anyAdditionalInvestigations,
                    ),
                    OSCESection(
                      title: 'Differential Diagnosis',
                      items: osce.differentialDiagnosis,
                    ),
                  ];

                  return sections[index];
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.white,
                    thickness: 1.0,
                    height: MediaQuery.of(context).size.height * 0.06,
                  );
                },
                itemCount: 6,
              ),
            );
          } else {
            return const ErrorInputWidget();
          }
        },
      ),
    );
  }
}

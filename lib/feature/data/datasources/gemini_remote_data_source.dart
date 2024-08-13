import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:osce_genius/core/constants/strings/app_strings.dart';
import '../models/prompt_model.dart';
import '../models/osce_model.dart';

class GeminiService {
  TextEditingController promptTextController = TextEditingController();
  
  
  

  final GenerativeModel model;

  GeminiService() : model = GenerativeModel(model: AppStrings.modelName, apiKey: AppStrings.apiKey);

  Future<OsceModel> generateContent(PromptData prompt) async {
    GenerateContentResponse response;
    if (prompt.image == null) {
      response = await _generateContentFromText(prompt);
    } else {
      response = await _generateContentFromMultiModal(prompt);
    }
    return _convertResponseToOsceModel(response);
  }

  Future<GenerateContentResponse> _generateContentFromText(
      PromptData prompt) async {
    final mainPromptText = mainPrompt(prompt.textInput);

    final response = await model.generateContent(
      [
        Content.text(
          mainPromptText,
        )
      ],
    );
    return response;
  }

  Future<GenerateContentResponse> _generateContentFromMultiModal(
      PromptData prompt) async {
    List<Content> content;
    final imageBytes = await prompt.image!.readAsBytes();
    final mainPromptText = mainPrompt(prompt.textInput);

    content = [
      Content.multi([
        TextPart(mainPromptText),
        DataPart('image/png', imageBytes),
      ])
    ];

    final response = await model.generateContent(
      content,
      generationConfig: GenerationConfig(temperature: 1, maxOutputTokens: 8192),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.high),
      ],
    );
    return response;
  }

  String mainPrompt(String? promptInput) {
    return '''
This is an educational app for medical students, not designed for real scenarios on real patients.
Generate a complete OSCE (objective structure clinical exam) based on the provided input. The input can be an image explaining the medical case or text or both of them. If the input doesn't contain a medical case or a patient complaint, output "${AppStrings.errorInput}".
The generated OSCE needs to be returned as valid JSON using the following structure:
{
  "historicalIllnessQuestions": ["question1", "question2", ...],
  "clinicalExaminationsToBePerformed": ["examination1", "examination2", ...],
  "bedsideInvestigationsToBePerformed": ["investigation1", "investigation2", ...],
  "initialLabInvestigations": ["investigation1", "investigation2", ...],
  "anyAdditionalInvestigations": ["investigation1", "investigation2", ...],
  "differentialDiagnosis": ["diagnosis1", "diagnosis2", ...]
}
${promptInput ?? ''}
''';
  }

  OsceModel _convertResponseToOsceModel(GenerateContentResponse response) {
    final generatedContent = response.text!;

    try {
      final cleanedContent = generatedContent
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();
      final responseData = OsceModel.fromJson(cleanedContent);
      return responseData;
    } catch (e) {
      throw FormatException(
          'Failed to parse response as JSON: $generatedContent');
    }
  }
}

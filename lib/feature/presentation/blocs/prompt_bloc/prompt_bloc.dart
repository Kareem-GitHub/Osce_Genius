import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/datasources/gemini_remote_data_source.dart';
import '../../../data/models/prompt_model.dart';
import 'prompt_event.dart';
import 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  String _text = '';
  bool _isCheckboxChecked = false;
  File? _image;

  PromptBloc()
      : super(const PromptState(
          isButtonEnabled: false,
          isCheckboxChecked: false,
          isImageIconEnabled: true,
          isTextInputEnabled: true,
          image: null,
          text: '',
        )) {
    on<TextChangedEvent>((event, emit) {
      _text = event.text;
      _updatePromptState(emit);
    });

    on<ImagePickedEvent>((event, emit) {
      _image = event.image;
      _updatePromptState(emit);
    });

    on<PickImageEvent>(_onPickImage);

    on<CheckboxChangedEvent>((event, emit) {
      _isCheckboxChecked = event.isChecked;
      _updatePromptState(emit);
    });

    on<ClearImageEvent>((event, emit) {
      _image = null;
      _updatePromptState(emit);
    });

    on<ResetOsceEvent>((event, emit) {
      emit(state.copyWith(osce: null));
    });

    on<GenerateOsceEvent>((event, emit) async {
      add(ResetOsceEvent());
      await _onGenerateOsce(event, emit);
    });
  }

  void _updatePromptState(Emitter<PromptState> emit) {
    final isValid = _text.isNotEmpty || _image != null;
    emit(PromptState(
      isButtonEnabled: isValid && _isCheckboxChecked,
      isCheckboxChecked: _isCheckboxChecked,
      isImageIconEnabled: true,
      isTextInputEnabled: true,
      image: _image,
      text: _text,
      osce: state.osce,
      isLoading: state.isLoading,
    ));
  }

  Future<void> _onPickImage(
      PickImageEvent event, Emitter<PromptState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      add(ImagePickedEvent(_image));
    }
  }

  Future<void> _onGenerateOsce(
      GenerateOsceEvent event, Emitter<PromptState> emit) async {
    emit(PromptState(
      isButtonEnabled: state.isButtonEnabled,
      isCheckboxChecked: state.isCheckboxChecked,
      isImageIconEnabled: state.isImageIconEnabled,
      isTextInputEnabled: state.isTextInputEnabled,
      image: state.image,
      text: state.text,
      isLoading: true,
      osce: null,
    ));
    final promptData = buildPrompt();
    final geminiService = GeminiService();
    try {
      final osce = await geminiService.generateContent(promptData);
      emit(PromptState(
        isButtonEnabled: state.isButtonEnabled,
        isCheckboxChecked: state.isCheckboxChecked,
        isImageIconEnabled: state.isImageIconEnabled,
        isTextInputEnabled: state.isTextInputEnabled,
        image: state.image,
        text: state.text,
        isLoading: false,
        osce: osce,
      ));
    } catch (e) {
      emit(PromptState(
        isButtonEnabled: state.isButtonEnabled,
        isCheckboxChecked: state.isCheckboxChecked,
        isImageIconEnabled: state.isImageIconEnabled,
        isTextInputEnabled: state.isTextInputEnabled,
        image: state.image,
        text: state.text,
        isLoading: false,
        osce: null,
      ));
    }
  }

  PromptData buildPrompt() {
    return PromptData(
      image: _image,
      textInput: _text.isNotEmpty ? _text : null,
    );
  }
}

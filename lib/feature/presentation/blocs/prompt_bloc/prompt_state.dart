import 'package:equatable/equatable.dart';
import 'dart:io';
import '../../../data/models/osce_model.dart';

class PromptState extends Equatable {
  final bool isButtonEnabled;
  final bool isCheckboxChecked;
  final bool isImageIconEnabled;
  final bool isTextInputEnabled;
  final File? image;
  final String text;
  final bool isLoading;
  final OsceModel? osce;

  const PromptState({
    required this.isButtonEnabled,
    required this.isCheckboxChecked,
    required this.isImageIconEnabled,
    required this.isTextInputEnabled,
    required this.image,
    required this.text,
    this.isLoading = false,
    this.osce,
  });

  @override
  List<Object?> get props => [
        isButtonEnabled,
        isCheckboxChecked,
        isImageIconEnabled,
        isTextInputEnabled,
        image,
        text,
        isLoading,
        osce,
      ];

  PromptState copyWith({
    bool? isButtonEnabled,
    bool? isCheckboxChecked,
    bool? isImageIconEnabled,
    bool? isTextInputEnabled,
    File? image,
    String? text,
    bool? isLoading,
    OsceModel? osce,
  }) {
    return PromptState(
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isCheckboxChecked: isCheckboxChecked ?? this.isCheckboxChecked,
      isImageIconEnabled: isImageIconEnabled ?? this.isImageIconEnabled,
      isTextInputEnabled: isTextInputEnabled ?? this.isTextInputEnabled,
      image: image ?? this.image,
      text: text ?? this.text,
      isLoading: isLoading ?? this.isLoading,
      osce: osce ?? this.osce,
    );
  }
}

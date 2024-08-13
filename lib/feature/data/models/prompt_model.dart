import 'dart:io';

class PromptData {
  PromptData({
    this.image,
    this.textInput,
  });

  PromptData.empty()
      : image = null,
        textInput = '';

  File? image;
  String? textInput;

  PromptData copyWith({
    File? image,
    String? textInput,
  }) {
    return PromptData(
      image: image ?? this.image,
      textInput: textInput ?? this.textInput,
    );
  }
}

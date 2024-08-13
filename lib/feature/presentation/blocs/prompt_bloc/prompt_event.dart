import 'dart:io';

abstract class PromptEvent {}

class TextChangedEvent extends PromptEvent {
  final String text;
  TextChangedEvent(this.text);
}

class ImagePickedEvent extends PromptEvent {
  final File? image;
  ImagePickedEvent(this.image);
}

class PickImageEvent extends PromptEvent {}

class CheckboxChangedEvent extends PromptEvent {
  final bool isChecked;
  CheckboxChangedEvent(this.isChecked);
}

class ClearImageEvent extends PromptEvent {}

class GenerateOsceEvent extends PromptEvent {}

class ResetOsceEvent extends PromptEvent {}

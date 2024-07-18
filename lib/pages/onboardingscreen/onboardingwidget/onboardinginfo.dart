import 'package:flutter/material.dart';

class OnboardingInfo {
  final String onTitle;
  final String onSubtitle;
  final String onDescriptions;
  final String onImage;
  final TextAlign onTitleAlign;
  final TextAlign onSubTitleAlign;

  OnboardingInfo({
    required this.onTitle,
    required this.onSubtitle,
    required this.onDescriptions,
    required this.onImage,
    required this.onTitleAlign,
    required this.onSubTitleAlign,
  });
}

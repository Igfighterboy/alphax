import 'package:flutter/painting.dart';
import 'package:myapp/pages/onboardingscreen/onboardingwidget/onboardinginfo.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      onTitle: "Welcome to \nALPhA MUSIX",
      onSubtitle: "Discover the ultimate music experience",
      onDescriptions:
          "Dive into a world of high-quality music with no ads.Enjoy your favorite tunes seamlessly",
      onImage: "assets/images/onboardingimages/welcome.svg",
    onTitleAlign: TextAlign.end,
    onSubTitleAlign: TextAlign.end,
    ),
    OnboardingInfo(
      onTitle: "Crystal Clear \nSound",
      onSubtitle: "Experience music like never before",
      onDescriptions:
          "Every note and beat is delivered in stunning clarity. Immerse yourself in high-definition audio.",
      onImage: "assets/images/onboardingimages/quality.svg",
    onTitleAlign: TextAlign.start,
    onSubTitleAlign: TextAlign.start,
    ),
    OnboardingInfo(
      onTitle: "ailored Just For \nYou",
      onSubtitle: "get playlists that match your mood",
      onDescriptions:
          "Discover personalized playlists curated to suit your taste. Your favorite music, always at your fingertips",
      onImage: "assets/images/onboardingimages/playlist.svg",
    onTitleAlign: TextAlign.end,
    onSubTitleAlign: TextAlign.end,
    ),
    OnboardingInfo(
      onTitle: "Uninterrupted listening",
      onSubtitle: "Enjoy music without any interruptions",
      onDescriptions:
          "Listen to your favorite tracks without any ads",
      onImage: "assets/images/onboardingimages/ads.svg",
    onTitleAlign: TextAlign.start,
    onSubTitleAlign: TextAlign.start,
    ),
    OnboardingInfo(
      onTitle: "Effortless Control",
      onSubtitle: "Navigate with ease",
      onDescriptions:
          "Explore ALPhA MUSIX with smooth and intuitive interface. Your music journey starts here.",
      onImage: "assets/images/onboardingimages/control.svg",
    onTitleAlign: TextAlign.end,
    onSubTitleAlign: TextAlign.end,
    ),
  ];
}

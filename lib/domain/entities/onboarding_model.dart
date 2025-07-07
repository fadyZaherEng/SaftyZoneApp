class OnboardingModel {
  final String image;
  final String titleKey;
  final String subtitleKey;

  OnboardingModel({
    required this.image,
    required this.titleKey,
    required this.subtitleKey,
  });

  static List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'assets/images/onboarding2.jpg',
      titleKey: 'welcomeTitle',
      subtitleKey: 'welcomeSubtitle',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.jpg',
      titleKey: 'professionalTitle',
      subtitleKey: 'professionalSubtitle',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding4.jpg',
      titleKey: 'easyTitle',
      subtitleKey: 'easySubtitle',
    ),
  ];
}

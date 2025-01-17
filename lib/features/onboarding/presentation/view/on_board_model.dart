// onboard_model.dart
class OnboardingPage {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

// Define the pages list
final List<OnboardingPage> pages = [
  OnboardingPage(
    imagePath: 'assets/images/home.png',
    title: 'Welcome to Bhumi',
    description:
        'Empowering farmers in Nepal by providing fair pricing and better market access.',
  ),
  OnboardingPage(
    imagePath: 'assets/images/home.png',
    title: 'Fair Pricing',
    description:
        'Eliminate middlemen and ensure farmers get the best value for their crops',
  ),
  OnboardingPage(
    imagePath: 'assets/images/home.png',
    title: 'Enhancing Market Access',
    description:
        'Connect farmers directly with buyers and improve farming opportunities.',
  ),
];

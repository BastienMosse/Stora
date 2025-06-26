import '/index.dart';

class OnboardingScreenViewModel {
  final BuildContext context;
  final PageController pageController = PageController();
  final List<Map<String, String>> pages;
  int currentPageIndex = 0;

  OnboardingScreenViewModel(this.context)
      : pages = [
          {
            'image': 'lib/assets/icons/check.jpg',
            'title': AppLocalizations.of(context)!.onBoarding_pageview1_title,
            'subtitle': AppLocalizations.of(context)!.onBoarding_pageview1_desc,
          },
          {
            'image': 'lib/assets/icons/loop.jpg',
            'title': AppLocalizations.of(context)!.onBoarding_pageview2_title,
            'subtitle': AppLocalizations.of(context)!.onBoarding_pageview2_desc,
          },
          {
            'image': 'lib/assets/icons/upgrade.jpg',
            'title': AppLocalizations.of(context)!.onBoarding_pageview3_title,
            'subtitle': AppLocalizations.of(context)!.onBoarding_pageview3_desc,
          },
          {
            'image': 'lib/assets/icons/stats.jpg',
            'title': AppLocalizations.of(context)!.onBoarding_pageview4_title,
            'subtitle': AppLocalizations.of(context)!.onBoarding_pageview4_desc,
          },
        ];

  bool get isLastPage => currentPageIndex == pages.length - 1;

  void nextPage() {
    if (isLastPage) {
      skipOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skipOnboarding() {
    context.pushReplacement('/home');
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
  }
  
  void dispose() {
    pageController.dispose();
  }
}
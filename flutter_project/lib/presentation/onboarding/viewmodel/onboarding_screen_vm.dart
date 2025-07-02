import '/index.dart';

class OnboardingScreenViewModel {
  BuildContext? _context;

  final PageController pageController = PageController();
  late final List<Map<String, String>> pages;

  late final UserPrefs userPrefs;

  int currentPageIndex = 0;
  bool get isLastPage => currentPageIndex == pages.length - 1;

  void init(BuildContext context) {
    if (_context != null) return;

    _context = context;
    userPrefs = context.watch<UserPrefs>();
    pages = [
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
  }

  BuildContext get context {
    if (_context == null) {
      throw StateError(
        'OnboardingScreenViewModel not initialized. Call init() first.',
      );
    }
    return _context!;
  }

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
    userPrefs.setFirstLaunch(false);
    context.pushReplacement('/login');
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
  }

  void dispose() {
    pageController.dispose();
    _context = null;
  }
}

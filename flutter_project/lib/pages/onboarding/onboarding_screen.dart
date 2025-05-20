import '/index.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  void _goToNextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _skipOnboarding() {
    context.go('/home');
  }


  List<Map<String, String>> get _pages {
    final loc = AppLocalizations.of(context)!;
    return [
      {
        'image': 'lib/assets/icons/check.jpg',
        'title': loc.onBoarding_pageview1_title,
        'subtitle': loc.onBoarding_pageview1_desc,
      },
      {
        'image': 'lib/assets/icons/loop.jpg',
        'title': loc.onBoarding_pageview2_title,
        'subtitle': loc.onBoarding_pageview2_desc,
      },
      {
        'image': 'lib/assets/icons/upgrade.jpg',
        'title': loc.onBoarding_pageview3_title,
        'subtitle': loc.onBoarding_pageview3_desc,
      },
      {
        'image': 'lib/assets/icons/stats.jpg',
        'title': loc.onBoarding_pageview4_title,
        'subtitle': loc.onBoarding_pageview4_desc,
      },
    ];
  }


  Widget _buildOnboardingPage(Map<String, String> page) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              page['image']!,
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            page['title']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page['subtitle']!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPageIndex == index ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                _currentPageIndex == index
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF555555),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    final loc = AppLocalizations.of(context)!;
    final isLastPage = _currentPageIndex == _pages.length - 1;

    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (_currentPageIndex != 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: _goToPreviousPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(loc.onBoarding_prev),
                  ),
                ),
              if (_currentPageIndex != 0 && _currentPageIndex != 3)
                const SizedBox(width: 10),
              if (_currentPageIndex != 3)
                Expanded(
                  flex: _currentPageIndex == 0 ? 2 : 1,
                  child: ElevatedButton(
                    onPressed: _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(loc.onBoarding_next),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Opacity(
                  opacity: 0.7,
                  child: OutlinedButton(
                    onPressed: _skipOnboarding,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2533),
                      foregroundColor: const Color(0xFF3C75EF),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(0, 40),
                    ),
                    child: Text(
                      isLastPage ? loc.onBoarding_finish : loc.onBoarding_skip,
                      style: const TextStyle(
                        color: Color(0xFF3C75EF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() => _currentPageIndex = index);
                      },
                      itemBuilder:
                          (context, index) =>
                              _buildOnboardingPage(_pages[index]),
                    ),
                  ),
                  _buildPageIndicator(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }
}
import '/index.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingScreenViewModel viewModel;
  bool _isViewModelInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isViewModelInitialized) {
      viewModel = OnboardingScreenViewModel();
      viewModel.init(context);
      _isViewModelInitialized = true;
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
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
        viewModel.pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: viewModel.currentPageIndex == index ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                viewModel.currentPageIndex == index
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

    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: viewModel.currentPageIndex == 0 ? 2 : 1,
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.nextPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    viewModel.isLastPage
                        ? loc.onBoarding_finish
                        : loc.onBoarding_next,
                  ),
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
                    onPressed: viewModel.skipOnboarding,
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
                      loc.onBoarding_skip,
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
    final theme = Provider.of<ThemeController>(context, listen: false);

    return Scaffold(
      backgroundColor: theme.currentTheme.PrimaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: viewModel.pageController,
                      itemCount: viewModel.pages.length,
                      physics:
                          (defaultTargetPlatform == TargetPlatform.android ||
                                  defaultTargetPlatform == TargetPlatform.iOS)
                              ? null
                              : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          viewModel.onPageChanged(index);
                        });
                      },
                      itemBuilder:
                          (context, index) =>
                              _buildOnboardingPage(viewModel.pages[index]),
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

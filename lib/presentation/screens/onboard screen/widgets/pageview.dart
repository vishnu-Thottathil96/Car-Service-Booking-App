import 'package:flutter/material.dart';
import 'package:motox/presentation/screens/onboard%20screen/widgets/oboardpage.dart';
import 'package:motox/utils/constants/onboard_content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageView extends StatelessWidget {
  OnboardingPageView({super.key});
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: onBoardData.length,
          onPageChanged: (value) {
            currentPage.value = value;
          },
          itemBuilder: (context, index) {
            final onBoardItem = onBoardData[index];

            return OnboardingPage(
              index: index,
              image: onBoardItem.image,
              title: onBoardItem.title,
              description: onBoardItem.description,
              pageController: pageController,
            );
          },
        ),
        ValueListenableBuilder(
            valueListenable: currentPage,
            builder: (context, value, _) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: AnimatedSmoothIndicator(
                    activeIndex: value,
                    count: 3,
                    effect: const ExpandingDotsEffect(),
                  ),
                ),
              );
            }),
      ],
    );
  }
}

ValueNotifier<int> currentPage = ValueNotifier(0);

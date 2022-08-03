import 'package:flutter/material.dart';
import 'package:intro_screens/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_screens/intro_screen1.dart';
import 'intro_screens/intro_screen2.dart';
import 'intro_screens/intro_screen3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //pages
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              if (index == 2) {
                setState(() {
                  lastPage = true;
                });
              }
            },
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3(),
            ],
          ),

          // dot screens
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          lastPage = false;
                        });
                        _controller.jumpToPage(0);
                      },
                      child: const Text("Skip")),

                  // smooth page indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.orange,
                        dotColor: Colors.grey,
                        dotHeight: 24.0,
                        dotWidth: 24.0,
                        spacing: 16.0,
                        offset: 16.0),
                  ),

                  lastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const HomeScreen();
                            }));
                          },
                          child: const Text("Done"))
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          child: const Text("Next")),
                ],
              ))
        ],
      ),
    );
  }
}

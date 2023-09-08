import 'dart:ui';

import 'package:anim_rive/core/functions/show_dialog.dart';
import 'package:anim_rive/core/utils/rive.dart';
import 'package:anim_rive/presentation/components/animated_btn.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isSignInDialogShown = false;
  final RiveAnimationController _btnAnimationController = OneShotAnimation(
    "active",
    autoplay: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.sizeOf(context).width * 1.7,
            bottom: 100,
            left: 100,
            child: Image.asset('assets/images/backgrounds/Spline.png'),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          const RiveAnimation.asset(RiveUtils.shapes),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox.shrink(),
            ),
          ),
          AnimatedPositioned(
            top: isSignInDialogShown ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 250,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Code Wave & Design',
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 60,
                                height: 1.2),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Don't skip design. Learn design and code. by building real apps with Flutter and Swift. Complete Courses about the best tools.",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isSignInDialogShown = true;
                            });
                            customSignInDialog(
                              context,
                              onClosed: (bool dialogClosed) {
                                if (dialogClosed) {
                                  setState(() {
                                    isSignInDialogShown = false;
                                  });
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

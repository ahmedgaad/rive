import 'package:anim_rive/core/utils/colors.dart';
import 'package:anim_rive/core/widgets/border.dart';
import 'package:anim_rive/presentation/screens/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rive',
      theme: ThemeData(
          scaffoldBackgroundColor: ColorUtils.scaffoldBg,
          primarySwatch: Colors.blue,
          fontFamily: "Inter",
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            errorStyle: TextStyle(height: 0),
            border: defautlInputBorder,
            enabledBorder: defautlInputBorder,
            focusedBorder: defautlInputBorder,
            errorBorder: defautlInputBorder,
          )),
      home: const OnBoardingScreen(),
    );
  }
}

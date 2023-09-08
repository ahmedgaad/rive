import 'package:anim_rive/presentation/components/sign_in_form.dart';
import 'package:anim_rive/presentation/components/social_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Object?> customSignInDialog(BuildContext context,
    {required ValueChanged<bool> onClosed}) {
  return showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      );
    },
    barrierDismissible: true,
    barrierLabel: "Sign In",
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 650,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 34,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.",
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                    ),
                    SignInForm(),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Sign Up with Emai, Apple or Google",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    SocialSignUp(),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -93,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      CupertinoIcons.clear,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  ).then((_) => onClosed(true));
}

import 'package:anim_rive/core/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: SvgPicture.asset(
            IconUtils.emailBox,
            height: 64,
            width: 64,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: SvgPicture.asset(
            IconUtils.appleBox,
            height: 64,
            width: 64,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: SvgPicture.asset(
            IconUtils.googleBox,
            height: 64,
            width: 64,
          ),
        )
      ],
    );
  }
}

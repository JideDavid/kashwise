import "package:flutter/material.dart";
import "package:kashwise/utils/constants/size_config.dart";

import "../constants/colors.dart";
import "../constants/sizes.dart";
class MLoadOverlay extends StatelessWidget {
  final String description;
  const MLoadOverlay({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: TColors.accent,
            ),
            const SizedBox(height: TSizes.paddingSpaceLg,),
            Text(description)
          ],
        ));
  }
}

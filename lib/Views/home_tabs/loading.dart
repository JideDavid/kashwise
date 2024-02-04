import 'package:flutter/material.dart';
import 'package:kashwise/utils/constants/size_config.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});


  @override
  State<LoadingPage> createState() => _LoadingPageState();
}
class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(TImages.logoCardVar6, width: SizeConfig.screenWidth * 0.4,),
              const SizedBox(height: TSizes.paddingSpaceLg,),
              const CircularProgressIndicator(
                strokeWidth: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}

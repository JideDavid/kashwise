import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../View_Models/user_details_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';
class BorrowTabSection extends StatelessWidget {
  const BorrowTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///
          /// Borrow section
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.paddingSpaceLg,
                vertical: TSizes.paddingSpaceSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ///flag
                    Image.asset(
                      TImages.nigerianFlag,
                      scale: 15,
                    ),
                    const SizedBox(
                      width: TSizes.paddingSpaceMd,
                    ),

                    ///owing
                    Text(
                      'You owe',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: TColors.pastelVar3),
                    )
                  ],
                ),
                const SizedBox(
                  height: TSizes.paddingSpaceMd,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///owing balance
                    Row(
                      children: [
                        Image.asset(
                          TImages.naira,
                          scale: 15,
                          color: TColors.pastelVar3,
                        ),
                        Text(
                          context
                              .watch<UserDetailsProvider>()
                              .owing
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: TColors.pastelVar3),
                        ),
                      ],
                    ),

                    ///wallet action button
                    const Icon(
                      Icons.expand_circle_down,
                      size: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.paddingSpaceLg,
                  vertical: TSizes.paddingSpaceSm),
              child: FilledButton(
                onPressed: (){},
                style: Theme.of(context).filledButtonTheme.style?.copyWith(
                  maximumSize: (MaterialStatePropertyAll(Size(
                    SizeConfig.screenWidth,
                    SizeConfig.screenHeight * 0.3
                  )))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.paddingSpaceLg * 2
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Overdraft', style: Theme.of(context).textTheme.headlineSmall,),
                            Column(
                              children: [
                                Text('Spend when your account balance is low and repay whenever you get paid', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Image.asset(TImages.empty, scale: 25,)
                  ],
                ),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.paddingSpaceLg,
                  vertical: TSizes.paddingSpaceSm),
              child: FilledButton(
                onPressed: (){},
                style: Theme.of(context).filledButtonTheme.style?.copyWith(
                  maximumSize: (MaterialStatePropertyAll(Size(
                    SizeConfig.screenWidth,
                    SizeConfig.screenHeight * 0.3
                  )))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.paddingSpaceLg * 2
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Salary Loan', style: Theme.of(context).textTheme.headlineSmall,),
                            Column(
                              children: [
                                Text('Get a salary based loan at an affordable interest rate', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Image.asset(TImages.emptySavings, scale: 25,)
                  ],
                ),
              )),


        ],
      ),
    );
  }
}

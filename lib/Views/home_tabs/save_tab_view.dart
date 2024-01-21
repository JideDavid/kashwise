import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../View_Models/user_details_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';

class SaveTabSection extends StatelessWidget {
  const SaveTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: () async {
        context.read<UserDetailsProvider>().incrementSavings();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///
            /// Savings section
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

                      ///currency
                      Text(
                        'NGN Savings',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: TColors.pastelVar1),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.paddingSpaceMd,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///wallet balance
                      Row(
                        children: [
                          Image.asset(
                            TImages.naira,
                            scale: 15,
                            color: TColors.pastelVar1,
                          ),
                          Text(
                            context
                                .watch<UserDetailsProvider>()
                                .totalSavings
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: TColors.pastelVar1),
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
                  Padding(
                    padding: const EdgeInsets.only(top: TSizes.paddingSpaceLg),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: Theme.of(context).filledButtonTheme.style,
                            onPressed: () {},
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.paddingSpaceLg),
                                  child: Icon(
                                    Icons.add_circle,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                Text(
                                  'Add Pocket',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.paddingSpaceLg,
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  )
                ],
              ),
            ),

            ///
            /// Pockets
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
              child: SizedBox(
                height: SizeConfig.screenHeight * 0.58,
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.paddingSpaceLg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        'Pockets',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: TSizes.paddingSpaceLg,
                      ),
                      Text(
                        'Put money away daily, weekly, monthly \n or as you spend',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: TSizes.paddingSpaceLg,
                      ),
                      Image.asset(
                        TImages.emptySavings,
                        scale: 8,
                      ),
                      const Spacer(),
                      FilledButton(
                        style: Theme.of(context)
                            .filledButtonTheme
                            .style
                            ?.copyWith(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context).primaryColor)),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Save Now',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Services/number_formatter.dart';
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
        context.read<UserDetailsProvider>().refreshUserDetails();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///
            /// Savings section
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.paddingSpaceXl,
                  vertical: TSizes.paddingSpaceSm),
              child: Container(
                decoration: BoxDecoration(
                    color: TColors.pastelVar1,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(image: AssetImage(TImages.savingsBG, ),opacity: 0.2, fit: BoxFit.cover)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.paddingSpaceLg * 2,
                      vertical: TSizes.paddingSpaceLg
                  ),
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
                                ?.copyWith(color: TColors.white),
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
                                color: TColors.white,
                              ),
                              Text(
                                NumberFormatter().formatAmount(Provider.of<UserDetailsProvider>(context, listen: true).account.totalSavings),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(color: TColors.white),
                              ),
                            ],
                          ),

                          ///wallet action button
                          const Visibility(
                            visible: false,
                            child: Icon(
                              Icons.expand_circle_down,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      
                      // Wallet action buttons
                      Padding(
                        padding: const EdgeInsets.only(top: TSizes.paddingSpaceLg),
                        child: Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                  backgroundColor: const MaterialStatePropertyAll(TColors.white)
                                ),
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
                                      'Add Pouch',
                                      style:
                                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            color: TColors.pastelVar1
                                          )
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
              ),
            ),

            ///
            /// Pockets
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
              child: SizedBox(
                height: SizeConfig.screenHeight * 0.5,
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.paddingSpaceLg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        'Pouches',
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
                                backgroundColor: const MaterialStatePropertyAll(TColors.pastelVar1)),
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

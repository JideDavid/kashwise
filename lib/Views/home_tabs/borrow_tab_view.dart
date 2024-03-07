import 'package:flutter/material.dart';
import 'package:kashwise/Views/borrow_and_invest/borrow_p2p.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../Services/number_formatter.dart';
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
                horizontal: TSizes.paddingSpaceXl,
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
                          NumberFormatter().formatAmount(Provider.of<UserDetailsProvider>(context, listen: true).account.totalOwe),
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

          ///
          /// Owe Categories

          /// P2P
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.paddingSpaceXl,
                  vertical: TSizes.paddingSpaceSm),
              child: FilledButton(
                onPressed: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const BorrowP2P(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
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
                          horizontal: TSizes.paddingSpaceLg
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('P2P', style: Theme.of(context).textTheme.headlineSmall,),
                            Column(
                              children: [
                                Text('Find users who are willing to lend you funds with interest', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
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

          /// Business
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.paddingSpaceXl,
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
                          horizontal: TSizes.paddingSpaceLg
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Business', style: Theme.of(context).textTheme.headlineSmall,),
                            Column(
                              children: [
                                Text('Register your business for user to invest', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
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

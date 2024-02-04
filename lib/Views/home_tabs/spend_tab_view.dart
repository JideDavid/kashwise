import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../View_Models/user_details_provider.dart';
import '../../View_Models/user_settings_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';
import '../add_money.dart';
import '../transfer.dart';

class SpendTabSection extends StatelessWidget {
  const SpendTabSection({super.key});

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
            /// wallet section
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
                        'Nigerian Naira',
                        style: Theme.of(context).textTheme.bodyLarge,
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
                      GestureDetector(
                        onTap: (){
                          context.read<UserSettingsProvider>().changeBalanceVisibility();
                        },
                        child: context.watch<UserSettingsProvider>().balIsHidden
                            ? const Text(
                          '*****',
                          style: TextStyle(fontSize: 30),
                        )
                            : Row(
                          children: [
                            Image.asset(
                              TImages.naira,
                              scale: 18,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.color,
                            ),
                            Text(
                              context.watch<UserDetailsProvider>().account.walletBalance
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge,
                            ),
                          ],
                        ),
                      ),



                      ///wallet action button
                      const Icon(
                        Icons.expand_circle_down,
                        size: 30,
                      )
                    ],
                  ),
                  Text('Pull down to refresh balance',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: TColors.darkGrey)),
                  Padding(
                    padding: const EdgeInsets.only(top: TSizes.paddingSpaceLg),
                    child: Row(
                      children: [
                        /// Transfer Button
                        Expanded(
                          child: FilledButton(
                            style: Theme.of(context).filledButtonTheme.style,
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const TransferPage(),
                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.paddingSpaceLg),
                                  child: Icon(
                                    Icons.expand_circle_down,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                Text(
                                  'Transfer',
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

                        /// Add Money Button
                        Expanded(
                          child: FilledButton(
                            style: Theme.of(context).filledButtonTheme.style,
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const AddMoneyPage(),
                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.paddingSpaceLg),
                                  child: Icon(
                                    Icons.payments,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                Text(
                                  'Add Money',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            ///
            /// Ad Carousel
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceLg),
              child: CarouselSlider(
                  items: [
                    1,
                    2,
                    3,
                  ]
                      .map((e) => Builder(builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: TSizes.paddingSpaceSm),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: e.isEven
                                        ? Colors.grey.withOpacity(0.05)
                                        : Colors.grey.withOpacity(0.08),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          e == 1
                                              ? TImages.carousel1
                                              : e == 2
                                                  ? TImages.carousel2
                                                  : TImages.carousel3,
                                        ),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              TSizes.paddingSpaceLg * 2),
                                      child: Icon(Icons.cancel),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                      .toList(),
                  options: CarouselOptions(
                      height: SizeConfig.screenHeight * 0.09,
                      viewportFraction: 0.85,
                      enlargeFactor: 0.5)),
            ),

            ///
            /// Quick Access Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
              child: Column(
                children: [
                  /// Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Access',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text('Edit',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.paddingSpaceLg,
                  ),

                  /// Buttons
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilledButton(
                          style: Theme.of(context)
                              .filledButtonTheme
                              .style!
                              .copyWith(
                                fixedSize: MaterialStatePropertyAll(Size(
                                    SizeConfig.screenWidth * 0.22,
                                    SizeConfig.screenWidth * 0.22)),
                              ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.perm_phone_msg,
                                color: TColors.pastelVar1,
                              ),
                              Text(
                                'Airtime',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.paddingSpaceLg,
                        ),
                        FilledButton(
                          style: Theme.of(context)
                              .filledButtonTheme
                              .style!
                              .copyWith(
                                fixedSize: MaterialStatePropertyAll(Size(
                                    SizeConfig.screenWidth * 0.22,
                                    SizeConfig.screenWidth * 0.22)),
                              ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.wifi,
                                color: TColors.pastelVar2,
                              ),
                              Text(
                                'Internet',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.paddingSpaceLg,
                        ),
                        FilledButton(
                          style: Theme.of(context)
                              .filledButtonTheme
                              .style!
                              .copyWith(
                                fixedSize: MaterialStatePropertyAll(Size(
                                    SizeConfig.screenWidth * 0.22,
                                    SizeConfig.screenWidth * 0.22)),
                              ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.live_tv,
                                color: TColors.pastelVar3,
                              ),
                              Text(
                                'TV',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.paddingSpaceLg,
                        ),
                        FilledButton(
                          style: Theme.of(context)
                              .filledButtonTheme
                              .style!
                              .copyWith(
                                fixedSize: MaterialStatePropertyAll(Size(
                                    SizeConfig.screenWidth * 0.22,
                                    SizeConfig.screenWidth * 0.22)),
                              ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.tungsten_sharp,
                                color: TColors.pastelVar4,
                              ),
                              Text(
                                'Electricity',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            ///
            /// Transaction History
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
              child: SizedBox(
                  height: SizeConfig.screenHeight * 0.45,
                  width: SizeConfig.screenWidth,
                  child:
                      //Empty list,
                      Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        TImages.empty,
                        scale: 10,
                      ),
                      const SizedBox(
                        height: TSizes.paddingSpaceLg,
                      ),
                      Text(
                        'Nothing to see yet.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: TSizes.paddingSpaceLg,
                      ),
                      Text(
                        'Spend or receive some money and \n '
                        'we\'ll show you your transactions',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: TSizes.paddingSpaceLg,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSpaceLg * 4),
                        child: FilledButton(
                          style: Theme.of(context).filledButtonTheme.style,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Request Statement',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

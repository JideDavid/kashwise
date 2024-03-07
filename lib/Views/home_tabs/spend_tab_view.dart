import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kashwise/utils/custom_widgets/m_transaction_card.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../Services/number_formatter.dart';
import '../../View_Models/user_details_provider.dart';
import '../../View_Models/user_settings_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';
import '../add_money.dart';
import '../payment_screens/transfer.dart';

class SpendTabSection extends StatefulWidget {
  const SpendTabSection({super.key});

  @override
  State<SpendTabSection> createState() => _SpendTabSectionState();
}

class _SpendTabSectionState extends State<SpendTabSection> {

  Future<bool> getAllTransactionHistory(BuildContext context) async {
    bool resp = await context.read<UserDetailsProvider>().getAllTransactionHistory(context);
      return resp;
  }

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
                horizontal: TSizes.paddingSpaceXl,
                // vertical: TSizes.paddingSpaceSm
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage(
                          TImages.walletBG,
                        ),
                        opacity: 0.2,
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.paddingSpaceLg * 2, vertical: TSizes.paddingSpaceLg),
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
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.paddingSpaceSm,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///wallet balance
                          GestureDetector(
                            onTap: () {
                              context.read<UserSettingsProvider>().changeBalanceVisibility();
                            },
                            child: context.watch<UserSettingsProvider>().balIsHidden
                                ? const Text(
                                    '*****',
                                    style: TextStyle(fontSize: 30, color: Colors.white),
                                  )
                                : Row(
                                    children: [
                                      Image.asset(
                                        TImages.naira,
                                        scale: 18,
                                        // color: Theme.of(context)
                                        //     .textTheme
                                        //     .headlineSmall
                                        //     ?.color,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        NumberFormatter().formatAmount(
                                            Provider.of<UserDetailsProvider>(context, listen: true)
                                                .account
                                                .walletBalance),
                                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                          ),

                          ///wallet action button
                          const Visibility(
                            visible: false,
                            child: Icon(
                              Icons.menu,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Text('Pull down to refresh balance',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.white, fontWeight: FontWeight.w400)),
                      Padding(
                        padding: const EdgeInsets.only(top: TSizes.paddingSpaceSm),
                        child: Row(
                          children: [
                            /// Transfer Button
                            Expanded(
                              child: FilledButton(
                                style: Theme.of(context)
                                    .filledButtonTheme
                                    .style!
                                    .copyWith(backgroundColor: const MaterialStatePropertyAll(TColors.white)),
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
                                      padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                                      child: Icon(
                                        Icons.send,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                    Text(
                                      'Transfer',
                                      style:
                                          Theme.of(context).textTheme.headlineSmall!.copyWith(color: TColors.primary),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: TSizes.paddingSpaceSm,
                            ),

                            /// Add Money Button
                            Expanded(
                              child: FilledButton(
                                style: Theme.of(context)
                                    .filledButtonTheme
                                    .style!
                                    .copyWith(backgroundColor: const MaterialStatePropertyAll(TColors.white)),
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
                                      padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                                      child: Icon(
                                        Icons.payments,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                    Text(
                                      'Add Money',
                                      style:
                                          Theme.of(context).textTheme.headlineSmall!.copyWith(color: TColors.primary),
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
              ),
            ),

            ///
            /// Ad Carousel
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.only(top: TSizes.paddingSpaceMd),
                child: CarouselSlider(
                    items: [
                      1,
                      2,
                      3,
                    ]
                        .map((e) => Builder(builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceSm),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: e.isEven ? Colors.grey.withOpacity(0.05) : Colors.grey.withOpacity(0.08),
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
                                        padding: EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg ),
                                        child: Icon(Icons.cancel),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))
                        .toList(),
                    options: CarouselOptions(
                        height: SizeConfig.screenHeight * 0.07, viewportFraction: 0.85, enlargeFactor: 0.5)),
              ),
            ),

            ///
            /// Quick Access Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl, vertical: TSizes.paddingSpaceLg),
              child: Column(
                children: [
                  /// Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Action',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.paddingSpaceSm,
                  ),

                  /// Buttons
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilledButton(
                          style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                fixedSize: MaterialStatePropertyAll(
                                    Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
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
                          style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                fixedSize: MaterialStatePropertyAll(
                                    Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
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
                          style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                fixedSize: MaterialStatePropertyAll(
                                    Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
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
                          style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                fixedSize: MaterialStatePropertyAll(
                                    Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
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

            /// Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  GestureDetector(
                    onTap: (){context.read<UserDetailsProvider>().getTransactionHistory(context);},
                    child: const Icon(Icons.refresh_sharp, color: TColors.accent, size: 20,),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: TSizes.paddingSpaceSm,
            ),

            FutureBuilder(
                future: getAllTransactionHistory(context),
                initialData: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        decoration: BoxDecoration(
                            // color: TColors.grey.withOpacity(0.1),
                          border: Border.all(color: TColors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        height: SizeConfig.screenHeight * 0.3,
                        width: SizeConfig.screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              TImages.empty,
                              scale: 18,
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
                          ],
                        )),
                  ),
                ),
                builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
                  if (snapshot.data == false) {
                    /// Empty list
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            decoration: BoxDecoration(
                                // color: TColors.grey.withOpacity(0.1),
                              border: Border.all(color: TColors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.3,
                            width: SizeConfig.screenWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  TImages.empty,
                                  scale: 18,
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
                              ],
                            )),
                      ),
                    );
                  } else if (snapshot.data == true) {

                    /// Transaction list
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Provider.of<UserSettingsProvider>(context).isLightMode
                              //     ? TColors.lightGrey
                              // :TColors.softBlack,
                              borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: TColors.grey.withOpacity(0.5))
                          ),
                          height: SizeConfig.screenHeight * 0.3,
                          width: SizeConfig.screenWidth,
                          child: ListView.builder(
                            itemCount: context.watch<UserDetailsProvider>().allTransactionList.length > 5
                                ? 6
                                : context.watch<UserDetailsProvider>().allTransactionList.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return context.watch<UserDetailsProvider>().allTransactionList.length > 5
                                  ? index == 5
                                      ///
                                      /// view more button
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(TSizes.paddingSpaceLg,
                                              TSizes.paddingSpaceSm, TSizes.paddingSpaceLg, TSizes.paddingSpaceLg),
                                          child: FilledButton(
                                            onPressed: () {},
                                            style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                                backgroundColor: const MaterialStatePropertyAll(TColors.primary),
                                                textStyle:
                                                    const MaterialStatePropertyAll(TextStyle(color: TColors.white))),
                                            child: const Text(
                                              'View all',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        )
                              ///
                              /// History card
                                      : Padding(
                                        padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
                                        child: TransactionCard(index: index,),
                                      )

                              ///
                              /// History card
                                  : Padding(
                                padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
                                child: TransactionCard(index: index,),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    /// Loading
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            decoration: BoxDecoration(
                                // color: TColors.grey.withOpacity(0.1),
                              border: Border.all(color: TColors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.3,
                            width: SizeConfig.screenWidth,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ),
                                SizedBox(
                                  height: TSizes.paddingSpaceLg,
                                ),
                                Text('Getting transactions')
                              ],
                            )),
                      ),
                    );
                  }
                }),

            ///
            /// Refresh space
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

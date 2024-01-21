import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/size_config.dart';
import '../utils/constants/sizes.dart';
class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        children: [

          ///
          ///Appbar
          Column(children: [

            ///Title and action Button
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.paddingSpaceLg,
                  horizontal: TSizes.paddingSpaceLg),
              child: Stack(
                children: [

                  /// Title
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pay',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ]),

                  /// Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ///Action button
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.speaker_notes,
                            color: TColors.accent,
                          ))
                    ]),

                ]
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 0,
            )
          ]),

          const SizedBox(height: TSizes.paddingSpaceLg,),

          ///
          /// Content body
           SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.symmetric(
                horizontal: TSizes.paddingSpaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                ///
                /// Essentials section

                /// Section headline
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.paddingSpaceLg,),
                  child: Text('Essentials',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 14)),
                ),

                /// Buttons
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      /// Airtime
                      FilledButton(
                        style: Theme.of(context).filledButtonTheme.style!.copyWith(
                          fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                        ),
                        onPressed: (){},
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
                      const SizedBox(width: TSizes.paddingSpaceLg,),

                      /// Internet
                      FilledButton(
                        style: Theme.of(context).filledButtonTheme.style!.copyWith(
                          fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),

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
                      const SizedBox(width: TSizes.paddingSpaceLg,),

                      /// Tv
                      FilledButton(
                        style: Theme.of(context).filledButtonTheme.style!.copyWith(
                          fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
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
                      const SizedBox(width: TSizes.paddingSpaceLg,),

                      ///Electricity
                      FilledButton(
                        style: Theme.of(context).filledButtonTheme.style!.copyWith(
                          fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
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
                ),

                const SizedBox(height: TSizes.paddingSpaceLg,),

                ///
                /// Cardless payments section

                /// Section headline
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: TSizes.paddingSpaceLg,),
                  child: Text('Cardless Payments',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 14)),
                ),

                /// Buttons
                Column(
                  children: [
                    FittedBox(
                      child: Column(
                        children: [
                          /// Row 1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              /// Pay ID
                              FilledButton(
                                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                  fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                ),
                                onPressed: (){},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.qr_code_scanner_sharp,
                                      color: TColors.pastelVar5,
                                    ),
                                    Text(
                                      'Pay ID',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: TSizes.paddingSpaceLg,),

                              /// USSD
                              FilledButton(
                                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                  fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),

                                ),
                                onPressed: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.tag,
                                      color: TColors.pastelVar4,
                                    ),
                                    Text(
                                      'USSD',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: TSizes.paddingSpaceLg,),

                              /// POS
                              FilledButton(
                                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                  fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                ),
                                onPressed: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.point_of_sale,
                                      color: TColors.pastelVar2,
                                    ),
                                    Text(
                                      'POS',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: TSizes.paddingSpaceLg,),

                              /// ATM
                              FilledButton(
                                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                  fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                ),
                                onPressed: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.credit_card_sharp,
                                      color: TColors.pastelVar1,
                                    ),
                                    Text(
                                      'ATM',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: TSizes.paddingSpaceLg,),

                          /// Row 2
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              /// Business
                              FilledButton(
                                style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                  fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                ),
                                onPressed: (){},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_business_rounded,
                                      color: TColors.pastelVar3,
                                    ),
                                    Text(
                                      'Business',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: TSizes.paddingSpaceLg,),

                              /// Empty
                              SizedBox(width: SizeConfig.screenWidth * 0.22,),
                              const SizedBox(width: TSizes.paddingSpaceLg,),

                              /// Empty
                              SizedBox(width: SizeConfig.screenWidth * 0.22,),
                              const SizedBox(width: TSizes.paddingSpaceLg,),

                              /// Empty
                              SizedBox(width: SizeConfig.screenWidth * 0.22,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: TSizes.paddingSpaceLg,),

                ///
                /// Essentials section

                /// Section headline
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: TSizes.paddingSpaceLg,),
                  child: Text('Essentials',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 14)),
                ),

                /// Buttons
                Column(
                  children: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          /// Betting
                          FilledButton(
                            style: Theme.of(context).filledButtonTheme.style!.copyWith(
                              fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                            ),
                            onPressed: (){},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.casino_outlined,
                                  color: TColors.pastelVar5,
                                ),
                                Text(
                                  'Betting',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: TSizes.paddingSpaceLg,),

                          /// Gift Cards
                          FilledButton(
                            style: Theme.of(context).filledButtonTheme.style!.copyWith(
                              fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),

                            ),
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.card_giftcard,
                                  color: TColors.pastelVar2,
                                ),
                                Text(
                                  'Gift Cards',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: TSizes.paddingSpaceLg,),

                          /// Transport
                          FilledButton(
                            style: Theme.of(context).filledButtonTheme.style!.copyWith(
                              fixedSize: MaterialStatePropertyAll(Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                            ),
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.local_taxi,
                                  color: TColors.pastelVar3,
                                ),
                                Text(
                                  'Transport',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: TSizes.paddingSpaceLg,),

                          /// Empty
                          SizedBox(width: SizeConfig.screenWidth * 0.22,),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kashwise/utils/constants/enums.dart';
import 'package:provider/provider.dart';
import '../../View_Models/user_settings_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class InvestTabSection extends StatefulWidget {
  const InvestTabSection({super.key});

  @override
  State<InvestTabSection> createState() => _InvestTabSectionState();
}

class _InvestTabSectionState extends State<InvestTabSection> {
  InvestType investType = InvestType.p2p;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            ///
            /// Tab button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg, vertical: TSizes.paddingSpaceLg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// p2p
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        investType = InvestType.p2p;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: investType == InvestType.p2p ? TColors.accent
                              : Provider.of<UserSettingsProvider>(context).isLightMode
                              ? TColors.white : TColors.darkerGrey,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm, horizontal: TSizes.paddingSpaceLg),
                            child: Text("P2P", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: investType == InvestType.p2p? Colors.black : Colors.grey),),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: TSizes.paddingSpaceLg),

                  /// business
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        investType = InvestType.business;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: investType == InvestType.business ? TColors.accent
                              : Provider.of<UserSettingsProvider>(context).isLightMode
                              ? TColors.white : TColors.darkerGrey,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm, horizontal: TSizes.paddingSpaceLg),
                        child: Text("business", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: investType == InvestType.business? Colors.black : Colors.grey),),
                      ),
                    ),
                  ),

                  const SizedBox(width: TSizes.paddingSpaceLg),

                  /// stock
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        investType = InvestType.stock;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: investType == InvestType.stock ? TColors.accent
                              : Provider.of<UserSettingsProvider>(context).isLightMode
                              ? TColors.white : TColors.darkerGrey,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm, horizontal: TSizes.paddingSpaceLg),
                        child: Text("stock", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: investType == InvestType.stock ? Colors.black : Colors.grey),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        /// p2p
        investType == InvestType.p2p ? Column(
          children: [
            /// Description
            Column(
              children: [
                Text('Lend to other ${TTexts.appName} users', style: Theme.of(context).textTheme.headlineSmall,),

                Text('lend as low as five thousand naira.', style: Theme.of(context).textTheme.bodySmall,),
              ],
            ),

            const SizedBox(height: TSizes.paddingSpaceLg,),

            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.3,
              color: Provider.of<UserSettingsProvider>(context).isLightMode
                  ? TColors.white : TColors.darkerGrey,
            ),

            const SizedBox(height: TSizes.paddingSpaceLg,),

            /// Button and footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
              child: Column(
                children: [
                  ///Find stock button
                  FilledButton(
                    style: Theme.of(context).filledButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Find a User',
                          style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg * 2),
                    child: Text('${TTexts.appName} doesn\'t give investment advice, Please consult your legal '
                        'financial and tax advisers before you buy stocks.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 11
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Powered by',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 8,
                      ),
                    ),
                      Image.asset(TImages.zalelStudios, scale:12,)
                    ],),
                ],
              ),
            ),
          ],
        )

        /// business
        : investType == InvestType.business ? Column(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.paddingSpaceLg
              ),
              child: Column(
                children: [
                  Text('Invest in vetted businesses', style: Theme.of(context).textTheme.headlineSmall,),

                  Text('lend as low as five thousand naira.', style: Theme.of(context).textTheme.bodySmall,),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  ///Find businesses
                  FilledButton(
                    style: Theme.of(context).filledButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Show Businesses',
                          style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg * 2),
                    child: Text('${TTexts.appName} doesn\'t give investment advice, Please consult your legal '
                        'financial and tax advisers before you buy stocks.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 11
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Powered by',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 8,
                      ),
                    ),
                      Image.asset(TImages.zalelStudios, scale:12,)
                    ],)

                ],
              ),
            ),
          ],
        )

        /// Stock
        : Column(

          children: [
            ///
            /// Chart cards
            CarouselSlider(
              items: [1, 2, 3, 4, 5]
                  .map((e) => Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.paddingSpaceSm),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FilledButton(
                      style: Theme.of(context)
                          .filledButtonTheme
                          .style
                          ?.copyWith(
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 0)),
                        backgroundColor: MaterialStatePropertyAll(TColors.grey.withOpacity(0.3))
                      ),
                      onPressed: () {},
                      child: Container(
                        width: SizeConfig.screenWidth * 0.25,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(e == 1
                                    ? TImages.facebookChart
                                    : e == 2
                                    ? TImages.spaceXChart
                                    : e == 3
                                    ? TImages.googleChart
                                    : e == 4
                                    ? TImages.instagramChart
                                    : TImages.microsoftChart))),
                      ),
                    ),
                  ),
                );
              }))
                  .toList(),
              options: CarouselOptions(
                  pageSnapping: true,
                  height: SizeConfig.screenHeight * 0.17,
                  viewportFraction: 0.29,
                  enlargeFactor: 0.5),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.paddingSpaceLg
              ),
              child: Column(
                children: [
                  Text('Investment made easy', style: Theme.of(context).textTheme.headlineSmall,),

                  Text('Buy stock as low as \$10.', style: Theme.of(context).textTheme.bodySmall,),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  ///Find stock button
                  FilledButton(
                    style: Theme.of(context).filledButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Find a Stock',
                          style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg * 2),
                    child: Text('${TTexts.appName} doesn\'t give investment advice, Please consult your legal '
                        'financial and tax advisers before you buy stocks.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 11
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: TSizes.paddingSpaceLg,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Powered by',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 8,
                      ),
                    ),
                      Image.asset(TImages.zalelStudios, scale:12,)
                    ],)

                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

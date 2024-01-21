import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/size_config.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

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
                            'Card',
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
                              child: Row(
                                children: [
                                  Text(
                                    'Get Card',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),

                                  const SizedBox(width: TSizes.paddingSpaceSm,),

                                  const Icon(
                                    Icons.add_circle,
                                    color: TColors.accent,
                                  ),
                                ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                /// ATM card image
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceLg * 4),
                  child: Image.asset(TImages.atmCard, width: SizeConfig.screenWidth * 0.7,),
                ),

                /// Buttons

                ///Send to app user button
                FilledButton(
                    style: Theme.of(context)
                        .filledButtonTheme
                        .style
                        ?.copyWith(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.grey.withOpacity(0))),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.paddingSpaceLg),
                      child: Row(
                        children: [
                          Image.asset(
                            TImages.brandCardIcon,
                            scale: 8,
                          ),
                          const SizedBox(
                            width: TSizes.paddingSpaceLg,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Request A Card',
                                style:
                                Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                'We\'ll send it to you wherever you are.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10),
                              )
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.navigate_next,
                            color: TColors.accent,
                          )
                        ],
                      ),
                    )),

                ///send to bank button
                FilledButton(
                    style: Theme.of(context)
                        .filledButtonTheme
                        .style
                        ?.copyWith(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.grey.withOpacity(0))),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.paddingSpaceLg),
                      child: Row(
                        children: [
                          Image.asset(
                            TImages.sendCardIcon,
                            scale: 8,
                          ),
                          const SizedBox(
                            width: TSizes.paddingSpaceLg,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card FAQs',
                                style:
                                Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                'Learn more about ${TTexts.appName} cards.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10),
                              )
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.navigate_next,
                            color: TColors.accent,
                          )
                        ],
                      ),
                    )),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class InvestTabSection extends StatelessWidget {
  const InvestTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        children: [
          ///
          /// Chart cards
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceLg * 4),
            child: CarouselSlider(
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
    );
  }
}

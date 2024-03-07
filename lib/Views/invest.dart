import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/size_config.dart';
import '../utils/constants/sizes.dart';
import 'home_tabs/borrow_tab_view.dart';
import 'home_tabs/invest_tab_view.dart';
class InvestPage extends StatefulWidget {
  const InvestPage({super.key});

  @override
  State<InvestPage> createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {

  int activeIndex = 0;

  CarouselController buttonCarouselController = CarouselController();

  moveToPage(int index){
    buttonCarouselController.animateToPage(
        index, duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [

          ///
          ///Appbar
          Column(children: [

            ///Title and action Button
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.paddingSpaceLg,
                  horizontal: TSizes.paddingSpaceXl),
              child: Column(
                children: [
                  Stack(
                      children: [

                        /// Title
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Invest',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ]),

                        /// Actions
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: []),
                      ]
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 0,
            )
          ]),


          ///Tab Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [

                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        activeIndex = 0;
                        moveToPage(activeIndex);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: activeIndex == 0 ? TColors.pastelVar1: Colors.grey.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Invest',
                                style: activeIndex == 0 ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: TColors.white) : Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        activeIndex = 1;
                        moveToPage(activeIndex);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: activeIndex == 1 ? TColors.pastelVar3.withOpacity(1) : Colors.grey.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Borrow',
                                style: activeIndex == 1 ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: TColors.white) : Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///
          /// Body Contents
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                child: CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: SizeConfig.screenHeight * 0.7,
                      viewportFraction: 1,
                      initialPage: activeIndex,
                      onPageChanged: (index, carouselPageChangedReason){
                        activeIndex = index;
                        setState(() {});
                      }
                  ),
                  items: [1,2,].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return i == 1 ? const InvestTabSection()
                            : const BorrowTabSection();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

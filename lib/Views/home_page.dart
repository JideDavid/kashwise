import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kashwise/utils/custom_widgets/m_display_picture.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:provider/provider.dart';
import '../View_Models/widget_state_provider.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/size_config.dart';
import '../utils/constants/sizes.dart';
import 'home_tabs/borrow_tab_view.dart';
import 'home_tabs/invest_tab_view.dart';
import 'home_tabs/save_tab_view.dart';
import 'home_tabs/spend_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();

  moveToPage(int index){
    buttonCarouselController.animateToPage(
        index, duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          ///
          ///Appbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
            child: SizedBox(
              child: Column(children: [
                ///User DP, Name and Help Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceLg),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///User DP, and Name
                        Row(
                          children: [
                            /// User DP
                            GestureDetector(
                              onTap: (){},
                                child: MDisplayPic(url: context.watch<UserDetailsProvider>().account.image)),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Hi, ${
                                  context.watch<UserDetailsProvider>().account.username
                              }',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                        ///Action button
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.speaker_notes, color: TColors.accent,))
                      ]),
                ),
                ///Tab Buttons
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                      onTap: (){
                context.read<WidgetStateProvider>().setActiveIndex(0);
                moveToPage(0);
                },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.watch<WidgetStateProvider>().homeActiveTab == 0 ? TColors.pastelVar1.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Text('Spend',
                        style: context.watch<WidgetStateProvider>().homeActiveTab == 0 ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: TColors.pastelVar1) : Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                      const SizedBox(width: 8,),
                      GestureDetector(
                        onTap: (){
                          context.read<WidgetStateProvider>().setActiveIndex(1);
                          moveToPage(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.watch<WidgetStateProvider>().homeActiveTab == 1 ? TColors.pastelVar2.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text('Save',
                              style: context.watch<WidgetStateProvider>().homeActiveTab == 1 ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: TColors.pastelVar2) : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      GestureDetector(
                        onTap: (){
                          context.read<WidgetStateProvider>().setActiveIndex(2);
                          moveToPage(2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.watch<WidgetStateProvider>().homeActiveTab == 2 ? TColors.pastelVar3.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text('Borrow',
                              style: context.watch<WidgetStateProvider>().homeActiveTab == 2 ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: TColors.pastelVar3) : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      GestureDetector(
                        onTap: (){
                          context.read<WidgetStateProvider>().setActiveIndex(3);
                          moveToPage(3);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.watch<WidgetStateProvider>().homeActiveTab == 3 ? TColors.pastelVar4.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text('Invest',
                              style: context.watch<WidgetStateProvider>().homeActiveTab == 3 ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: TColors.pastelVar3) : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),

          ///
          /// Body Contents
          Expanded(
            child: CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                  height: SizeConfig.screenHeight,
                viewportFraction: 1,
                initialPage: context.watch<WidgetStateProvider>().homeActiveTab,
                onPageChanged: (index, carouselPageChangedReason){
                    context.read<WidgetStateProvider>().setActiveIndex(index);
                }
              ),
              items: [1,2,3,4].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return i == 1 ? const SpendTabSection()
                    : i == 2 ? const SaveTabSection()
                    : i == 3 ? const BorrowTabSection()
                    : const InvestTabSection();
                  },
                );
              }).toList(),
            )
          ),
        ],
      ),
    );
  }
}

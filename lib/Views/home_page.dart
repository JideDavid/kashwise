import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kashwise/View_Models/user_settings_provider.dart';
import 'package:kashwise/utils/custom_widgets/m_display_picture.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:provider/provider.dart';
import '../View_Models/widget_state_provider.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/size_config.dart';
import '../utils/constants/sizes.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            ///
            ///Appbar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl),
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
                                onTap: (){
                                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("hello world")));
                                  context.read<UserDetailsProvider>().getTransactionHistory(context);
                                },
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
                ]),
              ),
            ),

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
                          context.read<WidgetStateProvider>().setActiveIndex(0);
                          moveToPage(0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.watch<WidgetStateProvider>().homeActiveTab == 0
                                ? TColors.primary
                                : Provider.of<UserSettingsProvider>(context).isLightMode ? TColors.white : TColors.darkGrey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Spend',
                                  style: context.watch<WidgetStateProvider>().homeActiveTab == 0 ? Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                          context.read<WidgetStateProvider>().setActiveIndex(1);
                          moveToPage(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.watch<WidgetStateProvider>().homeActiveTab == 1
                                ? TColors.pastelVar1
                                : Provider.of<UserSettingsProvider>(context).isLightMode ? TColors.white : TColors.darkGrey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Save',
                                  style: context.watch<WidgetStateProvider>().homeActiveTab == 1
                                      ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: TColors.white)
                                      : Theme.of(context).textTheme.bodyMedium,
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
                items: [1,2].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return i == 1 ? const SpendTabSection()
                      :  const SaveTabSection();
                    },
                  );
                }).toList(),
              )
            ),
          ],
        ),
      ),
    );
  }
}

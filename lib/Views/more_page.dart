import 'package:flutter/material.dart';
import 'package:kashwise/utils/custom_widgets/m_display_picture.dart';
import 'package:kashwise/Views/sign_in_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../utils/custom_widgets/m_nav_button.dart';
import '../View_Models/user_details_provider.dart';
import '../View_Models/user_settings_provider.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

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
                  horizontal: TSizes.paddingSpaceLg),
              child: Stack(alignment: AlignmentDirectional.center, children: [
                /// Title
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'More',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ]),

                /// Actions
                SizedBox(
                  height: 20,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Switch(
                        value: context.watch<UserSettingsProvider>().isLightMode,
                        onChanged: (mode) {
                          context
                              .read<UserSettingsProvider>()
                              .changeLightMode();
                        },
                      thumbIcon: MaterialStatePropertyAll(context.watch<UserSettingsProvider>().isLightMode
                          ? const Icon(Icons.light_mode, color: TColors.primary,)
                          : const Icon(Icons.light_mode_outlined, color: TColors.black,)),
                    )
                  ]),
                ),
              ]),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 0,
            )
          ]),

          ///
          /// Content body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Column(children: [
                      ///
                      /// User details button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: TSizes.paddingSpaceLg * 3,
                            horizontal: TSizes.paddingSpaceXl),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    MDisplayPic(url: context.watch<UserDetailsProvider>().account.image),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.watch<UserDetailsProvider>().account.username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        Text(
                                          'Account Details',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                ///Action button
                                const Icon(
                                  Icons.navigate_next,
                                  color: TColors.accent,
                                )
                              ]),
                        ),
                      ),

                      ///
                      /// Buttons

                      /// Get app for business
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
                                horizontal: TSizes.paddingSpaceXl,
                                vertical: TSizes.paddingSpaceMd),
                            child: Row(
                              children: [
                                Image.asset(
                                  TImages.brandCardIcon,
                                  scale: 24,
                                ),
                                const SizedBox(
                                  width: TSizes.paddingSpaceLg,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Register a business',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
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

                      /// Statement & reports
                      MNavButton(
                          function: () {},
                          iconColor: TColors.pastelVar1,
                          icon: const Icon(
                            Icons.description,
                            size: 18,
                            color: TColors.pastelVar1,
                          ),
                          subTitle: 'Download monthly statements',
                          title: 'Statements & Reports'),

                      /// Get Help
                      MNavButton(
                        function: () {},
                        iconColor: TColors.pastelVar3,
                        icon: const Icon(
                          Icons.question_answer_outlined,
                          size: 18,
                          color: TColors.pastelVar3,
                        ),
                        title: 'Get Help',
                        subTitle: 'Get support or send feedback',
                      ),

                      /// Security
                      MNavButton(
                          function: () {},
                          iconColor: TColors.pastelVar4,
                          icon: const Icon(
                            Icons.security,
                            size: 18,
                            color: TColors.pastelVar4,
                          ),
                          subTitle: 'Protect yourself from intruders',
                          title: 'Security'),

                      /// Referrals
                      MNavButton(
                          function: () {},
                          iconColor: TColors.pastelVar5,
                          icon: const Icon(
                            Icons.account_circle_rounded,
                            size: 18,
                            color: TColors.pastelVar5,
                          ),
                          subTitle:
                              'Earn money when your friends join ${TTexts.appName}',
                          title: 'Referrals'),

                      /// Account Limits
                      MNavButton(
                          function: () {},
                          iconColor: TColors.pastelVar1,
                          icon: const Icon(
                            Icons.receipt_long,
                            size: 18,
                            color: TColors.pastelVar1,
                          ),
                          subTitle: 'How much you can spend and receive',
                          title: 'Account Limits'),

                      /// Legal
                      MNavButton(
                          function: () {},
                          iconColor: TColors.pastelVar2,
                          icon: const Icon(
                            Icons.policy,
                            size: 18,
                            color: TColors.pastelVar2,
                          ),
                          subTitle: 'About our contract with you',
                          title: 'Legal'),

                      const SizedBox(
                        height: TSizes.paddingSpaceLg * 3,
                      ),

                      ///
                      ///  Sign Out
                      GestureDetector(
                        onTap: () {

                          /// sign user out
                          Provider.of<UserDetailsProvider>(context, listen: false).signOutGoogleUser();
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const SignInPage(),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Text(
                          'Sign Out',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: TColors.secondary),
                        ),
                      ),

                      const SizedBox(
                        height: TSizes.paddingSpaceLg * 3,
                      ),
                    ]),
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

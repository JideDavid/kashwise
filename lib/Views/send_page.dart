import 'package:flutter/material.dart';
import 'package:kashwise/Views/payment_screens/scan_qr_page.dart';
import 'package:kashwise/Views/payment_screens/transfer.dart';
import 'package:kashwise/utils/custom_widgets/m_nav_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../View_Models/user_details_provider.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/size_config.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.speaker_notes,
                      color: TColors.accent.withOpacity(0),
                    ),
                    Text(
                      'Send Money',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    ///Action button
                    GestureDetector(
                        onTap: () {
                        },
                        child: const Icon(
                          Icons.speaker_notes,
                          color: TColors.accent,
                        ))
                  ]),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 0,
            )
          ]),

          ///
          /// Content section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///
                  /// Add beneficiary section

                  ///Section headline
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.paddingSpaceLg,
                        horizontal: TSizes.paddingSpaceLg),
                    child: Text('Beneficiaries',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 14)),
                  ),

                  ///Add beneficiary button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.paddingSpaceLg),
                    child: Container(
                      width: double.maxFinite,
                      height: SizeConfig.screenHeight * 0.08,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSpaceLg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Send to Beneficiaries',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text('Add beneficiary to get started.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12)),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: TColors.accent,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: TSizes.paddingSpaceLg * 1.8,
                                        vertical: TSizes.paddingSpaceSm),
                                    child: Text(
                                      'Add',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontSize: 12,
                                              color: Colors.black),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: TSizes.paddingSpaceLg * 2,
                  ),

                  ///
                  ///Transfer Section

                  ///Free transfer count
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.paddingSpaceLg),
                    child: Row(
                      children: [
                        Text('Free transfer to other banks ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal)),
                        Text(
                            context
                                .watch<UserDetailsProvider>()
                                .account
                                .freeTransfers
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith()),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: TSizes.paddingSpaceLg * 2,
                  ),

                  ///Send to app user via WalletID
                  FilledButton(
                      style: Theme.of(context)
                          .filledButtonTheme
                          .style
                          ?.copyWith(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.grey.withOpacity(0))),
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const TransferPage(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSpaceLg),
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
                                  'Send to @walletID',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  'Send to any ${TTexts.appName} account for free.',
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

                  ///Send to app user via QR code
                  MNavButton(
                      function: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const ScanQRPage(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      iconColor: TColors.pastelVar3,
                      icon: const Icon(Icons.qr_code_scanner_sharp, color: TColors.pastelVar3,),
                      title: 'Send to user via QR code',
                      subTitle: 'Scan to any ${TTexts.appName} user code.'),

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
                                  'Send to Bank Account',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  'Send to a local bank account.',
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

                  ///
                  /// Transaction history section

                  ///Section headline
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.paddingSpaceLg,
                        horizontal: TSizes.paddingSpaceLg),
                    child: Text('Recent Transactions',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 14)),
                  ),

                  ///empty transaction view
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.paddingSpaceLg),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.3,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.storage,
                            size: 50,
                          ),
                          const SizedBox(
                            height: TSizes.paddingSpaceSm,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: TSizes.paddingSpaceLg,
                                horizontal: TSizes.paddingSpaceLg),
                            child: Text('Nothing to see yet.',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontSize: 14)),
                          ),
                          const SizedBox(
                            height: TSizes.paddingSpaceSm,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.paddingSpaceLg * 2),
                            child: Text(
                              'Send some money and we\'ll show you your recent transactions here.',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: TSizes.paddingSpaceLg,
                  ),

                  ///
                  /// Friends on app section

                  ///Section headline
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.paddingSpaceLg,
                        horizontal: TSizes.paddingSpaceLg),
                    child: Text('Friends on ${TTexts.appName}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 14)),
                  ),

                  ///Sync contact button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.paddingSpaceLg),
                    child: Container(
                      width: double.maxFinite,
                      height: SizeConfig.screenHeight * 0.08,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSpaceLg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sync your Contacts',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text('Free payments to contacts',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12)),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: TColors.accent,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: TSizes.paddingSpaceLg * 1.8,
                                        vertical: TSizes.paddingSpaceSm),
                                    child: Text(
                                      'Connect',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontSize: 12,
                                              color: Colors.black),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
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

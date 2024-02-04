import 'package:flutter/material.dart';
import 'package:kashwise/Views/payment_screens/fund_with%20_paystack.dart';
import 'package:kashwise/Views/payment_screens/generate_qr_code_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../utils/custom_widgets/m_nav_button.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';

class AddMoneyPage extends StatelessWidget {
  const AddMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ///
            /// Appbar
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
                      'Add Money',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ]),

                  /// Actions
                  SizedBox(
                    height: 20,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios_outlined),
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
            /// Buttons

            /// Share with username
            MNavButton(
              function: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const FundWithPaystackPage(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              iconColor: TColors.pastelVar2,
              icon: const Icon(
                Icons.payments_outlined,
                size: 18,
                color: TColors.pastelVar2,
              ),
              title: 'Paystack',
              subTitle: 'Fund your wallet using Paystack payment gateway.',
            ),

            /// Share with qr code
            MNavButton(
              function: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const GenerateQRCodePage(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              iconColor: TColors.pastelVar1,
              icon: const Icon(
                Icons.qr_code_scanner,
                size: 18,
                color: TColors.pastelVar1,
              ),
              title: 'Request payment via QR Code',
              subTitle:
                  'Receive money from ${TTexts.appName} users via QR code.',
            ),
          ],
        ),
      ),
    );
  }
}

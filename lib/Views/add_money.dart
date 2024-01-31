import 'package:flutter/material.dart';
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

            /// Share
            MNavButton(
              function: () {},
              iconColor: TColors.pastelVar2,
              icon: const Icon(
                Icons.alternate_email,
                size: 18,
                color: TColors.pastelVar2,
              ),
              title: 'Share @Username',
              subTitle: 'Receive money from other ${TTexts.appName} users with your Username.',
            ),

            /// Share
            MNavButton(
              function: () {},
              iconColor: TColors.pastelVar2,
              icon: const Icon(
                Icons.alternate_email,
                size: 18,
                color: TColors.pastelVar2,
              ),
              title: 'Share @Username',
              subTitle: 'Receive money from other ${TTexts.appName} users with your Username.',
            ),
          ],
        ),
      ),
    );
  }
}

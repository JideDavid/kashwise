import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';

class BorrowP2P extends StatefulWidget {
  const BorrowP2P({super.key});

  @override
  State<BorrowP2P> createState() => _BorrowP2PState();
}

class _BorrowP2PState extends State<BorrowP2P> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: TColors.accent,
          child: const Icon(Icons.add_circle, color: TColors.softBlack,),),
        body: Column(
          children: [
            ///
            /// Appbar
            Column(children: [
              ///Title and action Button
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceLg,),
                child: Stack(children: [
                  /// Title
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Borrow P2P',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ]),
      
                  /// Actions
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ///Action button
                    GestureDetector(
                        onTap: () {},
                        child: const Row(
                          children: [],
                        ))
                  ]),
                ]),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 0.8,
                height: 0,
              )
            ]),

            ///
            /// Body Contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl, vertical: TSizes.paddingSpaceMd),
              child: Container(
                decoration: BoxDecoration(
                  // color: Provider.of<UserSettingsProvider>(context).isLightMode
                  //     ? TColors.lightGrey
                  // :TColors.softBlack,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: TColors.grey.withOpacity(0.5))
                ),
                height: SizeConfig.screenHeight * 0.2,
                width: SizeConfig.screenWidth,
              ),
            ),
          ],
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/constants/sizes.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [

                      /// Title
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Transfer',
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
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined
                                ),
                              )
                            ]),
                      ),

                    ]
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 0.8,
                height: 0,
              )
            ]),

            ///
            ///
          ],
        ),
      ),
    );
  }
}
